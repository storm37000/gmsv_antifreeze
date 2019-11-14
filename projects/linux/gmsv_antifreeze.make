# Alternative GNU Make project makefile autogenerated by Premake

ifndef config
  config=release
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

# Configurations
# #############################################

RESCOMP = windres
DEFINES +=
INCLUDES += -I../../../include
FORCE_INCLUDE +=
ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
LIBS +=
LDDEPS +=
LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
define PREBUILDCMDS
endef
define PRELINKCMDS
endef
define POSTBUILDCMDS
endef

ifeq ($(config),release)
TARGETDIR = bin/Release
TARGET = $(TARGETDIR)/gmsv_antifreeze_linux.dll
OBJDIR = obj/Release
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -flto -ffast-math -fomit-frame-pointer -O3 -fPIC -msse3
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -flto -ffast-math -fomit-frame-pointer -O3 -fPIC -msse3 -std=c++11
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -flto -shared -Wl,-soname=gmsv_antifreeze_linux.dll -s

else ifeq ($(config),release64)
TARGETDIR = bin/Release64
TARGET = $(TARGETDIR)/gmsv_antifreeze_linux64.dll
OBJDIR = obj/Release64
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -flto -ffast-math -fomit-frame-pointer -O3 -fPIC -msse3
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -flto -ffast-math -fomit-frame-pointer -O3 -fPIC -msse3 -std=c++11
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -flto -shared -Wl,-soname=gmsv_antifreeze_linux64.dll -s

else ifeq ($(config),debug)
TARGETDIR = bin/Debug
TARGET = $(TARGETDIR)/gmsv_antifreeze_linux.dll
OBJDIR = obj/Debug
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -Og -fPIC -g -msse3
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -Og -fPIC -g -msse3 -std=c++11
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -shared -Wl,-soname=gmsv_antifreeze_linux.dll

else ifeq ($(config),debug64)
TARGETDIR = bin/Debug64
TARGET = $(TARGETDIR)/gmsv_antifreeze_linux64.dll
OBJDIR = obj/Debug64
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -Og -fPIC -g -msse3
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -Og -fPIC -g -msse3 -std=c++11
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -shared -Wl,-soname=gmsv_antifreeze_linux64.dll

else
  $(error "invalid configuration $(config)")
endif

# Per File Configurations
# #############################################


# File sets
# #############################################

OBJECTS :=

OBJECTS += $(OBJDIR)/main.o

# Rules
# #############################################

all: $(TARGET)
	@:

$(TARGET): $(OBJECTS) $(LDDEPS) | $(TARGETDIR)
	$(PRELINKCMDS)
	@echo Linking gmsv_antifreeze
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning gmsv_antifreeze
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild: | $(OBJDIR)
	$(PREBUILDCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) | $(PCH_PLACEHOLDER)
$(GCH): $(PCH) | prebuild
	@echo $(notdir $<)
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
$(PCH_PLACEHOLDER): $(GCH) | $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) touch "$@"
else
	$(SILENT) echo $null >> "$@"
endif
else
$(OBJECTS): | prebuild
endif


# File Rules
# #############################################

$(OBJDIR)/main.o: ../../src/main.cpp
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(PCH_PLACEHOLDER).d
endif