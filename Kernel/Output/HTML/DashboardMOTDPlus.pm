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

use Kernel::System::StandardResponse;

our $VERSION = 1.1;

our @ObjectDependencies = qw(
    Kernel::Output::HTML::Layout
    Kernel::System::StandardTemplate
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

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
    
    my %MOTD = $Kernel::OM->Get('Kernel::System::StandardTemplate')->StandardTemplateGet(
        ID => $ResponseID,
    );

    my $Content = $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentDashboardMOTDPlus',
        Data         => \%MOTD,
    );

    return $Content;
}

1;
