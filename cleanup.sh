#!/bin/bash
# echo "Please run this with root privileges. Pres Ctrl+C to cancel the script"
# echo ""

# Systemd logs
journalctl --disk-usage

while true; do
    echo "Clean up journald logs? (y/n)"
    read yn

    case $yn in
        y)  
            sudo journalctl --vacuum-size=500M && journalctl --vacuum-time=7d
            echo "==> Success"
            ;;
        n)
            # break
            ;;
        *)
            echo "Please give a valid input"
            continue
            ;;
    esac

    echo ""

    break
done

# Pacman old packages
echo "Scanning for old packages"
prune=$(paccache -dq)

if [ -z $prune ]
then
    echo "==> No candidate packages found for pruning"
    echo ""
else
    echo $prune
    echo ""
    while true; do
        echo "Clean up old packages? (y/n)"
        read yn

        case $yn in
            y)  
                paccache -rvuk0
                ;;
            n)
                # break
                ;;
            *)
                echo "Please give a valid input"
                continue
                ;;
        esac

        echo ""

        break
    done
fi

# Pacman cache
while true; do
    echo "Clean up uninstalled packages and unused sync database? (y/n)"
    read yn

    case $yn in
        y)  
            sudo pacman -Scc
            echo "==> Success"
            ;;
        n)
            # break
            ;;
        *)
            echo "Please give a valid input"
            continue
            ;;
    esac

    echo ""

    break
done

# Yay cache
while true; do
    echo "Clean up yay cache? (y/n)"
    read yn

    case $yn in
        y)  
            yay -Sc -a
            echo "==> Success"
            ;;
        n)
            # break
            ;;
        *)
            echo "Please give a valid input"
            continue
            ;;
    esac

    echo ""

    break
done

# Pamac cache
while true; do
    echo "Clean up pamac cache? (y/n)"
    read yn

    case $yn in
        y)  
            pamac clean -bv
            echo "==> Success"
            ;;
        n)
            # break
            ;;
        *)
            echo "Please give a valid input"
            continue
            ;;
    esac

    echo ""

    break
done