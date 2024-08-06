AM_SRCS := riscv/npc/start.S \
           riscv/npc/trm.c \
           riscv/npc/ioe.c \
           riscv/npc/timer.c \
           riscv/npc/input.c \
           riscv/npc/cte.c \
           riscv/npc/trap.S \
           platform/dummy/vme.c \
           platform/dummy/mpe.c

CFLAGS    += -fdata-sections -ffunction-sections
LDFLAGS   += -T $(Compiler_HOME)/scripts/linker.ld \
						 --defsym=_pmem_start=0x80000000 --defsym=_entry_offset=0x0
LDFLAGS   += --gc-sections -e _start
CFLAGS += -I$(Compiler_HOME)/am/src/riscv/npc/include
CFLAGS += -DMAINARGS=\"$(mainargs)\"
NPCFLAGS += -b
.PHONY: $(Compiler_HOME)/am/src/riscv/npc/trm.c

image: $(IMAGE).elf
	$(Q) $(OBJDUMP) -d $(IMAGE).elf > $(IMAGE).txt
	$(Q) echo + OBJCOPY "->" $(IMAGE_REL).bin
	$(Q) $(OBJCOPY) -S --set-section-flags .bss=alloc,contents -O binary $(IMAGE).elf $(IMAGE).bin

run: image
	$(MAKE) -C $(NPC_HOME) ISA=$(ISA) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin