include $(Compiler_HOME)/scripts/isa/riscv.mk
include $(Compiler_HOME)/scripts/platform/linux.mk


CFLAGS    += #-fdata-sections -ffunction-sections
LDFLAGS   += #-T $(Compiler_HOME)/scripts/linker.ld --defsym=_pmem_start=0x80000000 --defsym=_entry_offset=0x0
LDFLAGS   += #--gc-sections -e _start

CFLAGS += #-DMAINARGS=\"$(mainargs)\"
CFLAGS += #-I$(Compiler_HOME)/am/src/platform/nemu/include
.PHONY: $(Compiler_HOME)/am/src/platform/nemu/trm.c

image: $(IMAGE).elf
	$(Q) $(OBJDUMP) -d $(IMAGE).elf > $(IMAGE).txt
	$(Q) echo + OBJCOPY "->" $(IMAGE_REL).bin
	$(Q) $(OBJCOPY) -S  -O binary $(IMAGE).elf $(IMAGE).bin

run: image
	$(MAKE) -C $(NEMU_HOME) ISA=$(ISA) run ARGS="$(NEMUFLAGS)" IMG=$(IMAGE).bin

gdb: image
	$(MAKE) -C $(NEMU_HOME) ISA=$(ISA) gdb ARGS="$(NEMUFLAGS)" IMG=$(IMAGE).bin
