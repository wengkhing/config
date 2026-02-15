function saws --description 'Switch AWS profile'
    if test (count $argv) -eq 0
        echo "Usage: saws <profile-id>"
        echo "Available profiles:"
        grep -E '^\[profile.*\]' ~/.aws/config | sed 's/^\[profile //g' | sed 's/\]$//g' | head -n 10
        return 1
    end
    
    set profile $argv[1]
    
    # Check if profile exists
    if not grep -q "\[profile $profile\]" ~/.aws/config
        echo "Error: Profile '$profile' not found in ~/.aws/config"
        echo "Available profiles:"
        grep -E '^\[profile.*\]' ~/.aws/config | sed 's/^\[profile //g' | sed 's/\]$//g'
        return 1
    end
    
    # Set AWS profile
    set -gx AWS_PROFILE $profile
    echo "Switched to AWS profile: $profile"
    
    # Display current profile info
    if command -v aws >/dev/null 2>&1
        echo "Current identity:"
        aws sts get-caller-identity --query 'Account' --output text 2>/dev/null | sed 's/^/Account: /'
        aws sts get-caller-identity --query 'Arn' --output text 2>/dev/null | sed 's/^/ARN: /'
    end
end