use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDL::Raw::Grip;

use GTK::Container;

use GLib::Roles::Implementor;

our subset GdlDockItemGripAncestry is export of Mu
  where GdlDockItemGrip | GtkContainerAncestry;

class GDL::Grip is GTK::Container {
  has GdlDockItemGrip $!gdig is implementor;

  submethod BUILD ( :$dock-item-grip ) {
    self.setGdlDockItemGrip($dock-item-grip) if $dock-item-grip
  }

  method setGdlDockItemGrip (GdlDockItemGripAncestry $_) {
    my $to-parent;

    $!gdig = do {
      when GdlDockItemGrip {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockItemGrip, $_);
      }
    }
    self.setGtkContainer($to-parent);
  }

  method GDL::Raw::Structs::GdlDockItemGrip
    is also<GdlDockItemGrip>
  { $!gdig }

  multi method new (
     $dock-item-grip where * ~~ GdlDockItemGripAncestry,
    :$ref                                                = True
  ) {
    return unless $dock-item-grip;

    my $o = self.bless( :$dock-item-grip );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdlDockItem $item) {
    my $dock-item-grip = gdl_dock_item_grip_new($item);

    $dock-item-grip ?? self.bless( :$dock-item-grip ) !! Nil;
  }

  # Type: GdlDockItem
  method item is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Item.get_type);
    Proxy.new(
      FETCH => sub ($) {
        warn 'item does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GdlDockItem() $val is copy {
        $gv.object = $val;
        self.prop_set('item', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_item_grip_get_type, $n, $t );
  }

  method has_event (GdkEvent() $event) is also<has-event> {
    gdl_dock_item_grip_has_event($!gdig, $event);
  }

  method hide_handle is also<hide-handle> {
    gdl_dock_item_grip_hide_handle($!gdig);
  }

  method set_cursor (Int() $in_drag) is also<set-cursor> {
    my gboolean $i = $in_drag;

    gdl_dock_item_grip_set_cursor($!gdig, $i);
  }

  method set_label (GtkWidget() $label) is also<set-label> {
    gdl_dock_item_grip_set_label($!gdig, $label);
  }

  method show_handle is also<show-handle> {
    gdl_dock_item_grip_show_handle($!gdig);
  }

}
