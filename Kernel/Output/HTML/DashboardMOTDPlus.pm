# --
# Kernel/Output/HTML/DashboardMOTDPlus.pm
# Copyright (C) 2010 Daniel Obée
# --
# $Id: 
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::DashboardMOTDPlus;

use strict;
use warnings;

use Kernel::System::StdResponse;

use vars qw($VERSION);
$VERSION = qw($Revision: 1.31 $) [1];

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check all needed objects
    for (qw(ParamObject LayoutObject ConfigObject)) {
        if ( !$Self->{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $_!" );
        }
    }
    $Self->{StdResponseObject}   = Kernel::System::StdResponse->new(%Param);

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    return;
}

sub Config {
    my ( $Self, %Param ) = @_;

    return (
        %{ $Self->{Config} }
    );
}

sub Run {
    my ( $Self, %Param ) = @_;
    
    my $ResponseID = $Self->{Config}->{ResponseID};
    
 	my %MOTD = $Self->{StdResponseObject}->StdResponseGet( ID => $ResponseID );

    my $Content = $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentDashboardMOTDPlus',
        Data 		 => \%MOTD,
    );

    return $Content;
}

1;
