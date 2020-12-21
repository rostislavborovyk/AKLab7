ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
obj-m := lab7.o
ccflags-y += -g
else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build

default:
	$(MAKE) -C $(KDIR) M=$$PWD
	cp lab7.ko lab7.ko.unstripped
	$(CROSS_COMPILE)strip -g lab7.ko
clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean
%.s %.i: %.c
	$(MAKE) -C $(KDIR) M=$$PWD $@
endif
