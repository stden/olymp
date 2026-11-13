#!/usr/bin/perl

$lno = 0;

sub put_rights {
  my ($op, $m, $a, $b) = @_;
  return if ($a eq 'initial' || $b eq 'final');
  my $m2 = my $m1 = $GR{$a}{$b};
  $m2 = 0 | $m if ($op eq '=');
  $m2 |= $m if ($op eq '+');
  $m2 &= ~$m if ($op eq '-');
  return if ($m1 == $m2);
  if (!$m2) { delete $GR{$a}{$b};  delete $RG{$b}{$a};  return; }
  $GR{$a}{$b} = $RG{$b}{$a} = $m2;
#  print "added edge [$m2] from $a to $b.\n";
}

# checks rights graph node id
sub check_rnode {
  my ($x, $f) = @_;
  die "bad rights graph node $x" unless ($x =~ /^[A-Za-z0-9\-\_\.\/]{1,63}$/);
  $RNodes{$x} = 0 if ($f < 0 && !exists($RNodes{$x}));
  $RNodes{$x}++ if ($f > 0 && exists($RNodes{$x}));
  return $x;
}

# gets numeric value of a rights graph mask
sub conv_rmask {
  my $m = shift;
  return $m & 0xffffffff if ($m =~ /^\-?\d+$/);
  return -1 if ($m eq '-');
  return hex($m) & 0xffffffff if ($m =~ /^0x[0-9A-Fa-f]+$/);
  die "invalid rights mask value: $m";
}

# compute all right masks from a node
sub calc_rights_from {
  my ($S, $f) = @_;
  return if ($S eq '' || ($S eq $RFrom && !$f));
  $RFrom = $S;  $RTo = undef;
  %RightsTo = ($S => 0, 'final' => 0xffffffff);
  for (my $bit = 1;  $bit <= 4e9;  $bit += $bit) {
    my @Q = ($S, 'final');
    while (@Q) {
      my $x = shift @Q;
      my $p = $GR{$x};
      for my $y (keys %$p) {
        if ($p->{$y} & $bit && !($RightsTo{$y} & $bit)) {
          $RightsTo{$y} |= $bit;  push @Q, $y; }
  } } }
}

# compute all right masks to a node
sub calc_rights_to {
  my ($S, $f) = @_;
  return if ($S eq '' || ($S eq $RTo && !$f));
  $RTo = $S;  $RFrom = undef;
  %RightsFrom = ($S => 0, 'initial' => 0xffffffff);
  for (my $bit = 1;  $bit <= 4e9;  $bit += $bit) {
    my @Q = ($S, 'initial');
    while (@Q) {
      my $x = shift @Q;
      my $p = $RG{$x};
      for my $y (keys %$p) {
        if ($p->{$y} & $bit && !($RightsFrom{$y} & $bit)) {
          $RightsFrom{$y} |= $bit;  push @Q, $y; }
  } } }
}

# computes rights mask
sub calc_rights_mask {
  my ($S, $O, $self) = @_;
  calc_rights_from ($S) if ($S ne $RFrom && $O ne $RTo);
  my $m = $O eq $RTo ? $RightsFrom{$S} | $RightsFrom{'final'}
		     : $RightsTo{$O} | $RightsTo{'initial'};
  $m |= $self_rights_mask if $self;
  return $m;
}

# computes effective rights from rights mask
sub mask_to_er {
  my $x = shift;
  $x |= (($x >> 8) | ($x >> 16) | ($x >> 24));
  $x &= ~(($x >> 4) | ($x >> 8));
  $x |= (($x >> 8) | ($x >> 16) | ($x >> 24));
  return $x & 15;
}

# computes effective rights
sub calc_rights { return mask_to_er (calc_rights_mask (@_)); }

sub proc_line {
  my @L = @_;
  my $type = $L[3];
  my $id = $L[5];
  if ($type eq 'RIGHTS') {
      my $to = $L[6];
      my $e = calc_rights ($id, $to);
      my $s = ($e&8?'A':'').($e&4?'R':'').($e&2?'W':'').($e&1?'X':'');
      my $tmp = calc_rights_mask ($id, $to);
      $s = 'no' unless $s;
      print "$id has $s rights on $to with mask $tmp.\n";
  } elsif ($type =~ /^([\+\-\=])(GR|RG)$/) {
      $RFrom = $RTo = undef;
    my ($op, $rv) = ($1, $2 eq 'RG');
    check_rnode ($id, -1);
    my $mask = conv_rmask ($L[6]);
    for my $t (@L[7 .. $#L]) {
      if ($t ne '') {
        check_rnode ($t, -1);
        put_rights ($op, $mask, $rv ? ($t, $id) : ($id, $t));
    } }
} else { die "unknown record type $type"; }
}

sub split_line {
  $_ = shift;
  s/\r\n$/\n/g;
  chomp;
  my @L = split (/\t/);
  pop @L if (@L > 0 && $L[$#L] eq '');
  return @L;
}


sub read_file {
#  open FILE, "<$ttslog" || die "unable to open tts log $ttslog: $!";
  $lno = 0;
  %GR = ();
  %RG = ();
  %RNodes = ('initial' => 0, 'final' => 0);
  while (<ARGV>) {
    proc_line (++$lno, undef, split_line ($_));
  }
}

read_file();

