#****************************************************************************
#* setup.py for jitcc
#****************************************************************************
import os
import sys
import platform
from setuptools import Extension, find_namespace_packages

version="0.0.1"

proj_dir = os.path.dirname(os.path.abspath(__file__))

try:
    import sys
    sys.path.insert(0, os.path.join(proj_dir, "python"))
    from jitcc.__build_num__ import BUILD_NUM
    version += ".%s" % str(BUILD_NUM)
except ImportError:
    pass

isSrcBuild = False

try:
    from ivpm.setup import setup
    isSrcBuild = os.path.isdir(os.path.join(proj_dir, "src"))
    print("jitcc: running IVPM SrcBuild")
except ImportError as e:
    from setuptools import setup
    print("jitcc: running non-src build (%s)" % str(e))

if isSrcBuild:
    incdir = os.path.join(proj_dir, "src", "include")
else:
    incdir = os.path.join(proj_dir, "python/jitcc/share/include")

vsc_dir = proj_dir

ext = Extension("jitcc.core",
    sources=[
        os.path.join(vsc_dir, 'python', "core.pyx"), 
    ],
    language="c++",
    include_dirs=[incdir]
)
ext.cython_directives={'language_level' : '3'}

setup_args = dict(
  name = "jitcc",
  version=version,
  packages=find_namespace_packages(where='python'),
  package_dir = {'' : 'python'},
  author = "Matthew Ballance",
  author_email = "matt.ballance@gmail.com",
  description = ("Supports compiling and running C code on the fly"),
  long_description="""
  Support for compiling and running C code on the fly
  """,
  license = "Apache 2.0",
  keywords = ["JIT", "Verilog", "RTL", "Python"],
  url = "https://github.com/mballance-utils/jitcc",
  entry_points={
    'ivpm.pkginfo': [
        'jitcc = jitcc.pkginfo:PkgInfo'
    ]
  },
  install_requires=[
      'debug-mgr',
  ],
  setup_requires=[
    'setuptools_scm',
    'cython'
  ],
  ext_modules=[ ext ]
)

if isSrcBuild:
    setup_args["ivpm_extdep_pkgs"] = ["debug-mgr"]
    setup_args["ivpm_extra_data"] = {
        "jitcc": [
            ("src/include", "share"),
            ("build/{libdir}/{libpref}jitcc{dllext}", ""),
            ("build/{libdir}/{libpref}tcc{dllext}", "")
        ]
    }

setup(**setup_args)


