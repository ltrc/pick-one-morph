package pickonemorph;
use feature_filter;
use shakti_tree_api;
use Exporter qw(import);

our @EXPORT = qw(pickonemorph);

sub prune_default{


	# Keep the first FS in the case of more than one
	$sent=@_[0];
	my($parent);
	my($fs,@attr,@index);
	@index = &get_leaves($sent);
	
	for($i=0 ; $i<=$#index ; $i++)
	{
		($f0,$f1,$f2,$f3,$f4) = &get_fields($index[$i],$sent);
		$fs_ptr = &read_FS($f4,$sent);

		#first, update all the category in the FS based on the POS

		$num_of_fs = &get_num_fs($fs_ptr,$sent);
		if($num_of_fs > 1)
		{
			for($j = 2; $j <= $num_of_fs; $j++)
			{
				$ret=&prune_FS("",$j,$fs_ptr,$sent);
			}
		}

		$string=&make_string($fs_ptr,$sent);
		&modify_field($index[$i],4,$string,$sent);
	}
}

sub pickonemorph {
    my ($input, $output) = @_;
    read_story($input);

    $numBody = get_bodycount();
    for(my($bodyNum)=1;$bodyNum<=$numBody;$bodyNum++) {
        $body = get_body($bodyNum,$body);
        # Count the number of Paragraphs in the story
        my($numPara) = get_paracount($body);
        # Iterate through paragraphs in the story
        for(my($i)=1;$i<=$numPara;$i++)
        {
            my($para);
            # Read Paragraph
            $para = get_para($i);
            # Count the number of sentences in this paragraph
            my($numSent) = get_sentcount($para);
            #print $numSent."\n";
            # Iterate through sentences in the paragraph
            for(my($j)=1;$j<=$numSent;$j++)
            {
                #print " ... Processing sent $j\n";
                # Read the sentence which is in SSF format
                my($sent) = get_sent($para,$j);
                #       print_tree($sent);
                prune_default($sent);
            }
        }
    }
    if($output ne "") {
        printstory_file("$output");
    } else {
        printstory();
    }
}

1;
