#!/usr/bin/perl

use Term::ANSIColor;


$file='project.txt';
$dictionary='Dictionary.txt';

open($fh,'<:encoding(UTF-8)',$dictionary);
while(my $row=<$fh>)
{
	chomp($row);
	
	my @data=split(/\s+/,$row);
	@dict_array;
	push @dict_array,@data;
}
#close($fh);
@cotext;
@similar_array;
$line=-1;
open($fh,'<:encoding(UTF-8)',$file);
while(my $row=<$fh>)
{	
	$line++;
	#chomp($row);
	push @context,$row;
	
	chomp($row);
	#push @context,$row;
	print "$row\n";
	#print colored(['on_bright_white black'],"Yellow on magenta.");
	#print "\n";
	$row=~ tr/./ /;#刪除句點和逗點還有問號
	$row=~ tr/,/ /;
	$row=~ tr/?/ /;	
	my @data=split(/\s+/,$row);#切割空白建
	$leng=@data;
	for(my $i=0;$i<$leng;$i++)
	{
		my @replace;
		
		foreach my $k(@dict_array)
		{	
			
			if($data[$i] eq $k)
			{
				$correct=1;
				last;
			}
			else
			{	
				$correct=0;
				my @chr_word=split(undef,$data[$i]);
				my @chr_dict=split(undef,$k);
				my $match=0;
				
				for(my $j=0;$j<length($data[$i]);$j++)
				{
					if($j>length($k))
					{
						last;
					}
					elsif($chr_word[$j] eq $chr_dict[$j])
					{
						$match++;
					}
				}
				if(($match eq length($data[$i])-1) &&($chr_word[0] eq $chr_dict[0] || $chr_word[0] eq uc($chr_dict[0])))
				{	
					push @replace,$k;
				}
				
			}	
		}
		
			
		
		if($correct==0)
		{
			print "Do you want to modify the word (";
			print colored(['on_bright_white black'],"$data[$i]");
			print ")?\n";
			print color("bright_yellow"),"replace: \n",color("reset");
			$t=5;
			my $l=@replace;
			#print "replace:@replace\n";
			if($l<5)
			{
				$t=$l;
			}
			for(my $i=0;$i<$t;$i++)
			{
				print color("bright_yellow"),"\($i\)$replace[$i]\n",color("reset");

			}
			print color("bright_green"),"\n\(a\)Add\n\(i\)Ignore\n\(r\)Replace\n",color("reset");
			$select=<STDIN>;
			chomp($select);
			
			if($select eq 'r')
			{
				my $add=<STDIN>;
				chomp($add);
				$context[$line] =~ s/$data[$i]/$add/;
			}
			elsif($select eq '0'&& $l>=0)
			{
				
				$context[$line] =~ s/$data[$i]/$replace[0]/;
			}
			elsif($select eq '1'&& $l >=1)
			{	
				$context[$line] =~ s/$data[$i]/$replace[1]/;
			}
			elsif($select eq '2'&& $l>=2)
			{
				$context[$line] =~ s/$data[$i]/$replace[2]/;
			}
			elsif($select eq '3'&& $l>=3)
			{
				$context[$line] =~ s/$data[$i]/$replace[3]/;
			}
			elsif($select eq '4'&& $l >=4)
			{
				$context[$line] =~ s/$data[$i]/$replace[4]/;
			}
			elsif($select eq 'i')
			{
			}
			elsif($select eq 'a')
			{
				open(DICT,">>Dictionary.txt");
				print DICT "$data[$i]\n";
				close (DICT);
			}
		}
		
		
	}
	#print color("blue"),"@data\n",color("reset");
}


print "@context";

open(write_file,">project.txt");
for(my $i=0;$i<=$line;$i++)
{
	print write_file "$context[$i]";
}
close(write_file);


