#! /bin/sh
url="http://localhost/latest/meta-data/"
clear
echo
echo "+++++++++++Run this script within an EC2 instance to retrieve its meta-data+++++++++++++++"
echo
echo "Main Menu"
echo
choices1=( 'Display Instance MetaData' 'Exit the script' )
choices2=( 'Retrieve individual meta-data?' 'Exit the script' )

select choices1 in "${choices1[@]}"; do
[[ -n $choices1 ]] || { echo "Invalid choice." >&2; continue; }

  case $choices1 in
    'Display Instance MetaData')
        curl $url
      
        select choices2 in "${choices2[@]}"; do 
        [[ -n $choices2 ]] || { echo "Invalid choice." >&2; continue; }
       
        case $choices2 in
            'Retrieve individual meta-data?')
                echo "Enter the meta-data key you want to retrieve the data for?"
                read metadataKey
                curl $url$metadataKey
                echo "Select 1 to repeat or 2 to exit the script"
            ;;
            'Exit the script')
                echo "Thank you for using the meta-data retrieval script. Good Bye"
                exit 0
            ;;
        esac
        done
    ;;
    'Exit the script')
        echo "Thank you for using the meta-data retrieval script. Good Bye"
        exit 0
    ;;
    esac
done