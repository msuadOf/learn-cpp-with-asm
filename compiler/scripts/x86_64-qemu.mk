include $(Compiler_HOME)/scripts/isa/x86_64.mk
include $(Compiler_HOME)/scripts/platform/qemu.mk

AM_SRCS := x86/qemu/start64.S \
           x86/qemu/trap64.S \
           x86/qemu/trm.c \
           x86/qemu/cte.c \
           x86/qemu/ioe.c \
           x86/qemu/vme.c \
           x86/qemu/mpe.c

run: build-arg
	$(Q) qemu-system-x86_64 $(QEMU_FLAGS)
