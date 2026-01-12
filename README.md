# CMS COTS Avionics Builder

## Dependencies
- Docker

## Usage

Make sure to initialize and update the 
submodules when first cloning
```
git submodule update --init --recursive
```

Enter the build environment by running
```
./run-container.sh
```

You have to run `make` from within the container because
the ccache path is hardcoded as `/work/cache` in `buildroot-external/configs/pspl_cms_pi4_defconfig`
There are 2 options when building `cms` and `cph`
for CraterMaker Special and Copperhead respectively

To build the image for CMS, run (in the container)
```
make build TARGET=cms
```

For CPH, run (in the container)
```
make build TARGET=cph
```

## Code Map
```
├── buildroot-external
│   ├── board
│   │   └── raspberrypi
│   │       └── linux.config           # linux defconfig
│   ├── Config.in                      # unimportant
│   ├── configs
│   │   └── pspl_cms_pi4_defconfig     # buildroot defconfig
│   │   └── pspl_cph_pi4_defconfig     # buildroot defconfig
│   ├── external.desc                  # unimportant
│   ├── external.mk                    # unimportant
│   └── package                        # Packages
│       └── avi-cms-fsw                # For CMS   
│           └── avi-fsw.mk              
│           └── Config.in                 
│       └── avi-cph-fsw                # For CPH 
│           └── avi-fsw.mk                
│           └── Config.in                 
├── Dockerfile                         # dev container
├── Makefile                           # buildroot shortcuts
├── README.md
└── run-container.sh                   # build & run dev container
```

