#evb板子linux内核的目录 若无请为空
KERNELDIR_evb :=

#linux内核的目录
KERNELDIR :=	/home/yangjunwei/linux-code/itop4412_kernel_4_14_2_bsp/linux-4.14.2_iTop-4412_scp

# 结果需要拷贝的目录 若无请为空
mCOPYPATH  :=

# 驱动的名称.o
obj-m := itop4412_register_dev_drv.o
# APP的名称.o 若无请为空
obj-app := 



obj-ko = $(obj-m:%.o=%.ko)
target = $(obj-app:%.o=%)

# 平台
export ARCH=arm
# export ARCH=riscv

CURRENT_PATH := $(shell pwd)
ifeq ($(ARCH),arm)
mcc?= arm-none-linux-gnueabi-gcc
else
mcc?= riscv64-unknown-linux-gnu-gcc
endif 


# 正常编译 make
build: clean kernel_modules app copyres

# build: clean kernel_modules app

# 带参编译  make evb
evb: clean app kernel_modules_evb copyres

copyres:
ifneq ($(mCOPYPATH),)
	cp $(obj-ko) $(mCOPYPATH)
ifneq ($(obj-app),)
	cp  $(target) $(mCOPYPATH)
endif
else 
	@echo No path to copy result
endif


kernel_modules:
	$(MAKE) -C $(KERNELDIR) M=$(CURRENT_PATH) modules

kernel_modules_evb:
	$(MAKE) -C $(KERNELDIR_evb) M=$(CURRENT_PATH) modules
	cp $(obj-ko) $(mCOPYPATH)

app:$(obj-app)
ifneq ($(obj-app),)
	$(mcc)  $(obj-app) -o $(target)
else
	@echo No app to compile
endif
	
%.o:%.c
	$(mcc)   -c $< -o $@ 
clean:
	$(MAKE) -C $(KERNELDIR) M=$(CURRENT_PATH) clean
	rm -rf $(obj-app) $(target)











