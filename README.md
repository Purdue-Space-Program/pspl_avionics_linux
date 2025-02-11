# CMS COTS Avionics Builder

## Dependencies
- Docker

## Usage

Enter the build environment by running
```
./run-container.sh
```

You have to run `make` from within the container because
the ccache path is hardcoded as `/work/cache` in `br-ext-pspl-cms/configs/pspl_cms_pi4_defconfig`

To build the image, run
```
make config
make
```

## Code Map
```
├── br-ext-pspl-cms
│   ├── board
│   │   └── raspberrypi
│   │       └── linux.config           # linux defconfig
│   ├── Config.in                      # unimportant
│   ├── configs
│   │   └── pspl_cms_pi4_defconfig     # buildroot defconfig
│   ├── external.desc                  # unimportant
│   ├── external.mk                    # unimportant
│   └── package
│       └── pspl-cms-init              # custom init script
├── Dockerfile                         # dev container
├── Makefile                           # buildroot shortcuts
├── README.md
└── run-container.sh                   # build & run dev container
```

