##
# Project Title
#
# @file
# @version 0.1
all:run
boot.bin: doot.asm
	nasm -f bin doot.asm -o boot.bin
kernel.bin: kernel.asm
	nasm -f bin kernel.asm -o kernel.bin
my_os.img:kernel.bin boot.bin
	dd if=/dev/zero of=my_os.img bs=512 count=2880
	dd if=boot.bin of=my_os.img conv=notrunc
	dd if=kernel.bin of=my_os.img seek=1 conv=notrunc
run:my_os.img
	qemu-system-x86_64  my_os.img

# end
