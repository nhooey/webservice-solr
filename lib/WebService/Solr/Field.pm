package WebService::Solr::Field;
use XML::Generator;
use Tie::IxHash;
use Class::Accessor;
use warnings;
use strict;

sub new{
    my ( $class, %params ) = @_;
    # Accepts a hash of fields.
    my $self = {
        params=>\%params
    };
    bless $self,$class;
    return $self;

}
1;
sub to_xml{
    my $self = shift;
    my $params = $self->{params};
    my %paramshash = %$params;
    my $name = '';
    my $value= '';
    my $boost= '';
    # If boost has no value then set to default 1.0
    # Look for values of 'name' and 'value' attributes.
    if($paramshash{'boost'}){
            $boost= $paramshash{'boost'};
        }else{
            $boost = '1.0';
        }
    if($paramshash{'value'}||die "The field attribute 'value' is missing a value! "){
        $value  = $paramshash{'value'}; 
    }
    if($paramshash{'name'}||die "The field attribute 'name' is missing a value! "){
        $name  = $paramshash{'name'}; 
    }
    
    my $gen = XML::Generator->new(':pretty');

   my $str = $gen->field({name=>$name,boost=>$boost},$value);
    return "$str";
    
}

