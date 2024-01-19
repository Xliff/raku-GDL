use v6.c;

use NativeCall;

use GDL::Raw::Types;

role GDL::Roles::Signals::Object {
  has %!signals-gdo;

  #  GdlDockObject *requestor,  GdlDockPlacement position,  GValue *other_data, gpointer --> void
  method connect-dock (
    $obj,
    $signal = 'dock',
    &handler?
  ) {
    my $hid;
    %!signals-gdo{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-dock($obj, $signal,
        -> $, $gdo, $gdp, $v, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gdo, $gdp, $v, $ud] )
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdo{$signal}[0].tap(&handler) with &handler;
    %!signals-gdo{$signal}[0];
  }
}

# GdlDockObject *object,  GdlDockObject *requestor,  GdlDockPlacement position,  GValue *other_data
sub g-connect-dock (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GdlDockObject, GdlDockPlacement, GValue, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is      native(gobject)
  is      symbol('g_signal_connect_object')
{ * }
