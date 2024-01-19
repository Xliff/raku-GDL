use v6.c;

unit package GDL::Raw::Exports;

our @gdl-exports is export;

BEGIN {
  @gdl-exports = <
    GDL::Raw::Definitions
    GDL::Raw::Enums
    GDL::Raw::Structs
  >;
}
