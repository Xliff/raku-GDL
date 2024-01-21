use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDL::Raw::Types;

use GDL::Item;

use GLib::Roles::Implementor;

our subset GdlDockNotebookAncestry is export of Mu
  where GdlDockNotebook | GdlDockItemAncestry;

class GDL::Notebook is GDL::Item {
  has GdlDockNotebook $!gdn is implementor;

  submethod BUILD ( :$dock-notebook ) {
    self.setGdlDockNotebook($dock-notebook) if $dock-notebook
  }

  method setGdlDockNotebook (GdlDockNotebookAncestry $_) {
    my $to-parent;

    $!gdn = do {
      when GdlDockNotebook {
        $to-parent = cast(GdlDockItem, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockNotebook, $_);
      }
    }
    self.setGdlDockItem($to-parent);
  }

  method GDL::Raw::Definitions::GdlDockNotebook
    is also<GdlDockNotebook>
  { $!gdn }

  multi method new (
     $dock-notebook where * ~~ GdlDockNotebookAncestry,
    :$ref                                                = True
  ) {
    return unless $dock-notebook;

    my $o = self.bless( :$dock-notebook );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dock-notebook = gdl_dock_notebook_new();

    $dock-notebook ?? self.bless( :$dock-notebook ) !! Nil;
  }

  # Type: int
  method page is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('page', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('page', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_notebook_get_type, $n, $t );
  }

}

### /usr/src/gdl/gdl/gdl-dock-notebook.h

sub gdl_dock_notebook_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_notebook_new
  returns GdlDockNotebook
  is      native(gdl)
  is      export
{ * }
