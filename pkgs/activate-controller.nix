{ pkgs, lib, ... }:
pkgs.writers.writePython3 "/bin/activate-controller"
{
  libraries = with pkgs.python3Packages; [ pyusb ];
} ''
  import usb.core

  dev = usb.core.find(idVendor=0x045e, idProduct=0x028e)

  if dev is None:
      raise ValueError('Device not found')
  else:
      dev.ctrl_transfer(0xc1, 0x01, 0x0100, 0x00, 0x14)
''
