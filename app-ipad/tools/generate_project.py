#!/usr/bin/env python3
"""Génère QuranJournal.xcodeproj/project.pbxproj et les assets (couleurs + icônes PNG).

Usage : python3 tools/generate_project.py   (depuis le dossier app-ipad/)
Nécessite Pillow pour les icônes : pip install pillow
"""
import hashlib
import json
import math
import os
import struct
import zlib

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # app-ipad/
SRC = os.path.join(ROOT, "QuranJournal")
PROJ = os.path.join(ROOT, "QuranJournal.xcodeproj")
ASSETS = os.path.join(SRC, "Assets.xcassets")


def uuid(name: str) -> str:
    return hashlib.sha1(name.encode()).hexdigest()[:24].upper()


def hex_to_components(hex_color: str):
    h = hex_color.lstrip("#")
    r, g, b = (int(h[i:i + 2], 16) / 255.0 for i in (0, 2, 4))
    return r, g, b


def colorset_json(hex_color: str) -> dict:
    r, g, b = hex_to_components(hex_color)
    return {
        "colors": [
            {
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "alpha": "1.000",
                        "blue": f"{b:.3f}",
                        "green": f"{g:.3f}",
                        "red": f"{r:.3f}",
                    },
                },
                "idiom": "universal",
            }
        ],
        "info": {"author": "xcode", "version": 1},
    }


# ---------------------------------------------------------------- icônes PNG
def write_png(path, width, height, pixels):
    """Écrit un PNG RGBA minimal (pixels = fonction (x, y) -> (r, g, b, a))."""
    raw = bytearray()
    for y in range(height):
        raw.append(0)  # filtre None
        for x in range(width):
            raw.extend(pixels(x, y))
    def chunk(tag, data):
        c = struct.pack(">I", len(data)) + tag + data
        return c + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
    ihdr = struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)
    png = (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr)
           + chunk(b"IDAT", zlib.compress(bytes(raw), 9)) + chunk(b"IEND", b""))
    with open(path, "wb") as f:
        f.write(png)


def icon_pixel(size):
    """Carré arrondi vert foncé + croissant et étoile dorés."""
    green = (20, 83, 45)
    gold = (180, 83, 9)
    radius = size * 0.22
    cx, cy = size * 0.46, size * 0.5
    r1 = size * 0.34
    cx2 = size * 0.60
    r2 = size * 0.30
    # étoile 5 branches pleine (test point-dans-polygone)
    sx, sy, sr = size * 0.74, size * 0.33, size * 0.085
    star_pts = []
    for k in range(10):
        a = -math.pi / 2 + k * math.pi / 5
        r = sr if k % 2 == 0 else sr * 0.45
        star_pts.append((sx + r * math.cos(a), sy + r * math.sin(a)))

    def in_star(x, y):
        inside = False
        j = len(star_pts) - 1
        for i in range(len(star_pts)):
            xi, yi = star_pts[i]
            xj, yj = star_pts[j]
            if (yi > y) != (yj > y) and x < (xj - xi) * (y - yi) / (yj - yi) + xi:
                inside = not inside
            j = i
        return inside

    def pixel(x, y):
        fx, fy = (x + 0.5) / size, (y + 0.5) / size
        # distance au bord du carré arrondi
        qx, qy = min(fx, 1 - fx), min(fy, 1 - fy)
        rr = min(qx, qy)
        d_corner = math.hypot(max(qx - radius / size, 0), max(qy - radius / size, 0))
        inside = (qx >= radius / size or qy >= radius / size or d_corner <= radius / size)
        if not inside:
            return (0, 0, 0, 0)
        d1 = math.hypot(x - cx, y - cy)
        d2 = math.hypot(x - cx2, y - cy)
        if d1 <= r1 and d2 >= r2:
            return (*gold, 255)
        if in_star(x, y):
            return (*gold, 255)
        return (*green, 255)
    return pixel


ICON_SIZES = {
    "icon-20.png": 20, "icon-40.png": 40, "icon-58.png": 58, "icon-60.png": 60,
    "icon-76.png": 76, "icon-80.png": 80, "icon-87.png": 87, "icon-120.png": 120,
    "icon-152.png": 152, "icon-167.png": 167, "icon-180.png": 180, "icon-1024.png": 1024,
}

APPICON_IMAGES = [
    {"filename": "icon-40.png", "idiom": "iphone", "scale": "2x", "size": "20x20"},
    {"filename": "icon-60.png", "idiom": "iphone", "scale": "3x", "size": "20x20"},
    {"filename": "icon-58.png", "idiom": "iphone", "scale": "2x", "size": "29x29"},
    {"filename": "icon-87.png", "idiom": "iphone", "scale": "3x", "size": "29x29"},
    {"filename": "icon-80.png", "idiom": "iphone", "scale": "2x", "size": "40x40"},
    {"filename": "icon-120.png", "idiom": "iphone", "scale": "3x", "size": "40x40"},
    {"filename": "icon-120.png", "idiom": "iphone", "scale": "2x", "size": "60x60"},
    {"filename": "icon-180.png", "idiom": "iphone", "scale": "3x", "size": "60x60"},
    {"filename": "icon-20.png", "idiom": "ipad", "scale": "1x", "size": "20x20"},
    {"filename": "icon-40.png", "idiom": "ipad", "scale": "2x", "size": "20x20"},
    {"filename": "icon-58.png", "idiom": "ipad", "scale": "1x", "size": "29x29"},
    {"filename": "icon-80.png", "idiom": "ipad", "scale": "2x", "size": "29x29"},
    {"filename": "icon-40.png", "idiom": "ipad", "scale": "1x", "size": "40x40"},
    {"filename": "icon-80.png", "idiom": "ipad", "scale": "2x", "size": "40x40"},
    {"filename": "icon-76.png", "idiom": "ipad", "scale": "1x", "size": "76x76"},
    {"filename": "icon-152.png", "idiom": "ipad", "scale": "2x", "size": "76x76"},
    {"filename": "icon-167.png", "idiom": "ipad", "scale": "2x", "size": "83.5x83.5"},
    {"filename": "icon-1024.png", "idiom": "ios-marketing", "scale": "1x", "size": "1024x1024"},
]


def generate_assets():
    os.makedirs(ASSETS, exist_ok=True)
    with open(os.path.join(ASSETS, "Contents.json"), "w") as f:
        json.dump({"info": {"author": "xcode", "version": 1}}, f, indent=2)

    for name, hex_color in [("AccentColor", "#14532D"), ("LaunchBackground", "#FAF6EE")]:
        d = os.path.join(ASSETS, f"{name}.colorset")
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, "Contents.json"), "w") as f:
            json.dump(colorset_json(hex_color), f, indent=2)

    icon_dir = os.path.join(ASSETS, "AppIcon.appiconset")
    os.makedirs(icon_dir, exist_ok=True)
    for filename, size in ICON_SIZES.items():
        write_png(os.path.join(icon_dir, filename), size, size, icon_pixel(size))
    with open(os.path.join(icon_dir, "Contents.json"), "w") as f:
        json.dump({"images": APPICON_IMAGES, "info": {"author": "xcode", "version": 1}}, f, indent=2)


# ---------------------------------------------------------------- pbxproj
def collect_sources():
    groups = {}
    for dirpath, dirnames, filenames in os.walk(SRC):
        dirnames[:] = [d for d in dirnames if d != "Assets.xcassets"]
        for filename in sorted(filenames):
            if filename.endswith(".swift"):
                rel = os.path.relpath(os.path.join(dirpath, filename), SRC)
                groups.setdefault(os.path.dirname(rel), []).append(rel)
    return groups


def generate_pbxproj():
    groups = collect_sources()
    swift_files = sorted(f for files in groups.values() for f in files)

    u = uuid
    ids = {
        "project": u("project"),
        "mainGroup": u("mainGroup"),
        "productsGroup": u("productsGroup"),
        "appGroup": u("appGroup"),
        "target": u("target"),
        "appProduct": u("appProduct"),
        "sourcesPhase": u("sourcesPhase"),
        "frameworksPhase": u("frameworksPhase"),
        "resourcesPhase": u("resourcesPhase"),
        "projConfigList": u("projConfigList"),
        "targetConfigList": u("targetConfigList"),
        "projDebug": u("projDebug"),
        "projRelease": u("projRelease"),
        "tgtDebug": u("tgtDebug"),
        "tgtRelease": u("tgtRelease"),
        "assetsRef": u("Assets.xcassets"),
        "infoPlistRef": u("Info.plist"),
        "assetsBuild": u("Assets.xcassets in Resources"),
    }

    build_files = []
    file_refs = []
    for rel in swift_files:
        ref = u(f"ref:{rel}")
        build = u(f"build:{rel}")
        file_refs.append(
            f"\t\t{ref} /* {os.path.basename(rel)} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = {os.path.basename(rel)}; sourceTree = \"<group>\"; }};")
        build_files.append(
            f"\t\t{build} /* {os.path.basename(rel)} in Sources */ = {{isa = PBXBuildFile; fileRef = {ref} /* {os.path.basename(rel)} */; }};")

    file_refs.append(
        f"\t\t{ids['appProduct']} /* QuranJournal.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = QuranJournal.app; sourceTree = BUILT_PRODUCTS_DIR; }};")
    file_refs.append(
        f"\t\t{ids['assetsRef']} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = \"<group>\"; }};")
    file_refs.append(
        f"\t\t{ids['infoPlistRef']} /* Info.plist */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = \"<group>\"; }};")
    build_files.append(
        f"\t\t{ids['assetsBuild']} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {ids['assetsRef']} /* Assets.xcassets */; }};")

    def group_children(rel_dir):
        children = []
        for f in groups.get(rel_dir, []):
            children.append(u(f"ref:{f}"))
        for sub in sorted(d for d in groups if d and os.path.dirname(d) == rel_dir):
            children.append(u(f"group:{sub}"))
        if rel_dir == "":
            children.append(ids["assetsRef"])
            children.append(ids["infoPlistRef"])
        return children

    def group_block(rel_dir):
        gid = u(f"group:{rel_dir}") if rel_dir else ids["appGroup"]
        children = group_children(rel_dir)
        names = []
        for c in children:
            if c == ids["assetsRef"]:
                names.append(f"{c} /* Assets.xcassets */")
            elif c == ids["infoPlistRef"]:
                names.append(f"{c} /* Info.plist */")
            else:
                sub = next((d for d in groups if d and u(f"group:{d}") == c), None)
                if sub:
                    names.append(f"{c} /* {os.path.basename(sub)} */")
                else:
                    ref = next((f for f in swift_files if u(f"ref:{f}") == c), None)
                    names.append(f"{c} /* {os.path.basename(ref)} */" if ref else c)
        child_lines = ",\n".join(f"\t\t\t\t{n}" for n in names)
        path_attr = f'path = "{rel_dir}"; ' if rel_dir else "path = QuranJournal; "
        return (f"\t\t{gid} = {{\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n{child_lines},\n\t\t\t);\n"
                f"\t\t\t{path_attr}sourceTree = \"<group>\";\n\t\t}};")

    group_blocks = [group_block(d) for d in sorted(groups, key=lambda d: (d.count("/"), d))]

    sources_files = ",\n".join(f"\t\t\t\t{u(f'build:{f}')} /* {os.path.basename(f)} in Sources */" for f in swift_files)

    pbx = f"""// !$*UTF8*$!
{{
	archiveVersion = 1;
	classes = {{
	}};
	objectVersion = 56;
	objects = {{

/* Begin PBXBuildFile section */
{chr(10).join(build_files)}
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
{chr(10).join(file_refs)}
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		{ids['frameworksPhase']} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		{ids['mainGroup']} = {{
			isa = PBXGroup;
			children = (
				{ids['appGroup']} /* QuranJournal */,
				{ids['productsGroup']} /* Products */,
			);
			sourceTree = "<group>";
		}};
		{ids['productsGroup']} /* Products */ = {{
			isa = PBXGroup;
			children = (
				{ids['appProduct']} /* QuranJournal.app */,
			);
			name = Products;
			sourceTree = "<group>";
		}};
{chr(10).join(group_blocks)}
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		{ids['target']} /* QuranJournal */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {ids['targetConfigList']} /* Build configuration list for PBXNativeTarget "QuranJournal" */;
			buildPhases = (
				{ids['sourcesPhase']} /* Sources */,
				{ids['frameworksPhase']} /* Frameworks */,
				{ids['resourcesPhase']} /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = QuranJournal;
			productName = QuranJournal;
			productReference = {ids['appProduct']} /* QuranJournal.app */;
			productType = "com.apple.product-type.application";
		}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		{ids['project']} /* Project object */ = {{
			isa = PBXProject;
			attributes = {{
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1540;
				LastUpgradeCheck = 1540;
			}};
			buildConfigurationList = {ids['projConfigList']} /* Build configuration list for PBXProject "QuranJournal" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = {ids['mainGroup']};
			productRefGroup = {ids['productsGroup']} /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				{ids['target']} /* QuranJournal */,
			);
		}};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		{ids['resourcesPhase']} /* Resources */ = {{
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				{ids['assetsBuild']} /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		{ids['sourcesPhase']} /* Sources */ = {{
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
{sources_files},
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		{ids['projDebug']} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = ("DEBUG=1", "$(inherited)");
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
			}};
			name = Debug;
		}};
		{ids['projRelease']} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				SWIFT_VERSION = 5.0;
				VALIDATE_PRODUCT = YES;
			}};
			name = Release;
		}};
		{ids['tgtDebug']} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = QuranJournal/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "app.quranjournal.journal";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SUPPORTS_MACCATALYST = NO;
				SWIFT_EMIT_LOC_STRINGS = NO;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Debug;
		}};
		{ids['tgtRelease']} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = QuranJournal/Info.plist;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "app.quranjournal.journal";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SUPPORTS_MACCATALYST = NO;
				SWIFT_EMIT_LOC_STRINGS = NO;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			}};
			name = Release;
		}};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		{ids['projConfigList']} /* Build configuration list for PBXProject "QuranJournal" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{ids['projDebug']} /* Debug */,
				{ids['projRelease']} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{ids['targetConfigList']} /* Build configuration list for PBXNativeTarget "QuranJournal" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{ids['tgtDebug']} /* Debug */,
				{ids['tgtRelease']} /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
/* End XCConfigurationList section */
	}};
	rootObject = {ids['project']} /* Project object */;
}}
"""
    os.makedirs(PROJ, exist_ok=True)
    with open(os.path.join(PROJ, "project.pbxproj"), "w") as f:
        f.write(pbx)


if __name__ == "__main__":
    generate_assets()
    generate_pbxproj()
    print("OK: assets + project.pbxproj générés dans", ROOT)
