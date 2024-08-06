.PHONY: build-arg

LDFLAGS    += -N -Ttext-segment=0x00100000
QEMU_FLAGS += -serial mon:stdio \
              -machine accel=tcg \
              -smp "$(smp)" \
              -drive format=raw,file=$(IMAGE)

build-arg: image
	$(Q) ( echo -n $(mainargs); ) | dd if=/dev/stdin of=$(IMAGE) bs=512 count=2 seek=1 conv=notrunc status=none

BOOT_HOME := $(Compiler_HOME)/am/src/x86/qemu/boot

image: $(IMAGE).elf
	$(Q) $(MAKE) -s -C $(BOOT_HOME)
	$(Q) echo + CREATE "->" $(IMAGE_REL)
	$(Q) ( cat $(BOOT_HOME)/bootblock.o; head -c 1024 /dev/zero; cat $(IMAGE).elf ) > $(IMAGE)
