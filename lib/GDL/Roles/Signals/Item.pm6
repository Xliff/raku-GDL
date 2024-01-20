use v6.c;

use NativeCall;

use GDK::Device;

use GDL::Raw::Types;

role GDL::Roles::Signals::Item {
  has %!signals-gdi;

  #  GdkDevice *device,  gint x,  gint y --> void
  method connect-dock-drag-motion (
     $obj,
     $signal    = 'dock-drag-motion',
     &handler?,
    :$raw       = False
  ) {
    my $hid;
    %!signals-gdi{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-dock-drag-motion($obj, $signal,
        -> $, $gd is copy, $g1, $g2, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          $gd = GDK::Device.new($gd) unless $raw;

          𝒮.emit( [self, $gd, $g1, $g2, $ud] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdi{$signal}[0].tap(&handler) with &handler;
    %!signals-gdi{$signal}[0];
  }

}

# GdlDockItem *item,  GdkDevice *device,  gint x,  gint y
sub g-connect-dock-drag-motion (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GdkDevice, gint, gint, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
