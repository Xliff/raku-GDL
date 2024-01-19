use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDK::Raw::Object;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GDO::Roles::Signals::Object;

our subset GdlDockObjectAncestry is export of Mu
  where GdlDockObject | GtkContainerAncestry;

class GDL::Object {
  also does GLib::Roles::Object;
  also does GDO::Roles::Signals::Object;

  has GdlDockObject $!gdo is implementor;

  submethod BUILD ( :$dock-object ) {
    self.setGdlDockObject($dock-object) if $dock-object
  }

  method setGdlDockObject (GdlDockObjectAncestry $_) {
    my $to-parent;

    $!gdo = do {
      when GdlDockObject {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockObject, $_);
      }
    }
    self.setGtkContainer($to-parent);
  }

  method GDL::Raw::Definitions::GdlDockObject
    is also<GdlDockObject>
  { $!gdo }

  multi method new (
     $dock-object where * ~~ GdlDockObjectAncestry,
    :$ref                                           = True
  ) {
    return unless $dock-object;

    my $o = self.bless( :$dock-object );
    $o.ref if $ref;
    $o;
  }

  method long-name is rw  is g-property is also<long_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('long-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('long-name', $gv);
      }
    );
  }

  # Type: GdlDockMaster
  method master ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Master.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('master', $gv);
        propReturnObject($gv.object, $raw, |GDL::Master.getTypePair)
      },
      STORE => -> $,  GdlDockMaster() $val is copy {
        $gv.object = $val;
        self.prop_set('master', $gv);
      }
    );
  }

  # Type: pointer
  method pixbuf-icon ( :$raw = False )
    is rw
    is g-property
    is also<pixbuf_icon>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixbuf-icon', $gv);
        propReturnObject($gv.pointer, $raw, |GDK::Pixbuf.getTypePair);
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.pointer = $val;
        self.prop_set('pixbuf-icon', $gv);
      }
    );
  }

  # Type: string
  method stock-id is rw  is g-property is also<stock_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('stock-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('stock-id', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Is originally:
  # GdlDockObject *object,  gboolean recursive --> void
  method detach {
    self.connect-boolean($!gdo, 'detach');
  }

  # Is originally:
  # GdlDockObject *object,  GdlDockObject *requestor,  GdlDockPlacement position,  GValue *other_data --> void
  method dock {
    self.connect-dock($!gdo);
  }

  method bind (GObject() $master) {
    gdl_dock_object_bind($!gdo, $master);
  }

  method child_placement (
    GdlDockObject()    $child,
    GdlDockPlacement() $placement
  )
    is also<child-placement>
  {
    gdl_dock_object_child_placement($!gdo, $child, $placement);
  }

  method detach (Int() $recursive) {
    my gboolean $r = $recursive;

    gdl_dock_object_detach($!gdo, $r);
  }

  method dock (
    GdlDockObject() $requestor,
    Int()           $placement
    GValue()        $other_data
  ) {
    my GdlDockPlacement $p = $position,

    gdl_dock_object_dock($!gdo, $requestor, $p, $other_data);
  }

  method dock_request (
    Int()            $xx,
    Int()            $yy,
    GdlDockRequest() $request
  )
    is also<dock-request>
  {
    my gint ($x, $y) = ($xx, $yy);

    gdl_dock_object_dock_request($!gdo, $x, $y, $request);
  }

  method freeze {
    gdl_dock_object_freeze($!gdo);
  }

  method get_controller ( :$raw = False ) is also<get-controller> {
    propReturnObject(
      gdl_dock_object_get_controller($!gdo),
      $raw,
      |GDL::Object.getTypePair
    );
  }

  method get_long_name is also<get-long-name> {
    gdl_dock_object_get_long_name($!gdo);
  }

  method get_master ( :$raw = False ) is also<get-master> {
    propReturnObject(
      gdl_dock_object_get_master($!gdo),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_name is also<get-name> {
    gdl_dock_object_get_name($!gdo);
  }

  method get_parent_object ( :$raw = False ) is also<get-parent-object> {
    propReturnObject(
      gdl_dock_object_get_parent_object($!gdo),
      $raw,
      |GDL::Object.getTypePair
    );
  }

  method get_pixbuf ( :$raw = False ) is also<get-pixbuf> {
    propReturnObject(
      gdl_dock_object_get_pixbuf($!gdo),
      $raw,
      |GDK::Pixbuf.getTypePair
    );
  }

  method get_stock_id is also<get-stock-id> {
    gdl_dock_object_get_stock_id($!gdo);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_object_get_type, $n, $t );
  }

  method is_automatic is also<is-automatic> {
    so gdl_dock_object_is_automatic($!gdo);
  }

  method is_bound is also<is-bound> {
    so gdl_dock_object_is_bound($!gdo);
  }

  method is_closed is also<is-closed> {
    so gdl_dock_object_is_closed($!gdo);
  }

  method is_compound is also<is-compound> {
    so gdl_dock_object_is_compound($!gdo);
  }

  method is_frozen is also<is-frozen> {
    so gdl_dock_object_is_frozen($!gdo);
  }

  method layout_changed_notify is also<layout-changed-notify> {
    gdl_dock_object_layout_changed_notify($!gdo);
  }

  method nick_from_type is also<nick-from-type> {
    gdl_dock_object_nick_from_type($!gdo);
  }

  method present (GdlDockObject() $child) {
    gdl_dock_object_present($!gdo, $child);
  }

  method reduce {
    gdl_dock_object_reduce($!gdo);
  }

  method reorder (
    GdlDockObject() $child,
    Int()           $new_position,
    GValue()        $other_data
  ) {
    my GdlDockPlacement $n = $new_position;

    so gdl_dock_object_reorder($!gdo, $child, $n, $other_data);
  }

  method set_long_name (Str() $name) is also<set-long-name> {
    gdl_dock_object_set_long_name($!gdo, $name);
  }

  method set_manual is also<set-manual> {
    gdl_dock_object_set_manual($!gdo);
  }

  method set_name (Str() $name) is also<set-name> {
    gdl_dock_object_set_name($!gdo, $name);
  }

  method set_pixbuf (GdkPixbuf() $icon) is also<set-pixbuf> {
    gdl_dock_object_set_pixbuf($!gdo, $icon);
  }

  method set_stock_id (Str() $stock_id) is also<set-stock-id> {
    gdl_dock_object_set_stock_id($!gdo, $stock_id);
  }

  method set_type_for_nick (Str() $nick,Int() $type)
    is static
    is also<set-type-for-nick>
  {
    my GType $t = $type;

    gdl_dock_object_set_type_for_nick($nick, $t);
  }

  method thaw {
    gdl_dock_object_thaw($!gdo);
  }

  method type_from_nick (Str() $nick) is static is also<type-from-nick> {
    gdl_dock_object_type_from_nick($nick);
  }

  method unbind {
    gdl_dock_object_unbind($!gdo);
  }

}
