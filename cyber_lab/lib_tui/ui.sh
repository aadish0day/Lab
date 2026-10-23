#!/usr/bin/env bash
# ==============================================================================
# CyberLab Pure Bash TUI Engine & UI Primitives
# ==============================================================================
# Provides standard TUI dialog interfaces reading directly from /dev/tty.
# Supports 'dialog' (primary) with fallback to 'whiptail' and pure CLI.
# Configures high-contrast cyber/hacker theme and full Vim keybindings.
# ==============================================================================

UI_TOOL="${UI_TOOL:-none}"
DIALOGRC_FILE=""

# ------------------------------------------------------------------------------
# Debian / Ubuntu Dependency Auto-Installation Fallback (apt)
# ------------------------------------------------------------------------------

ui_get_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        echo ""
        return 0
    fi
    if command -v sudo >/dev/null 2>&1; then
        echo "sudo"
        return 0
    fi
    return 1
}

ui_install_package() {
    local pkg_name="$1"
    local sudo_cmd
    sudo_cmd=$(ui_get_sudo || true)

    local deb_pkg="$pkg_name"
    [[ "$pkg_name" == "tput" ]] && deb_pkg="ncurses-bin"

    printf '\033[1;36m[CyberLab]\033[0m Installing missing dependency via apt: \033[1;33m%s\033[0m...\n' "$deb_pkg"

    if [ -n "$sudo_cmd" ]; then
        $sudo_cmd apt-get update -qq || true
        DEBIAN_FRONTEND=noninteractive $sudo_cmd apt-get install -y "$deb_pkg" || return 1
    elif [ "$(id -u)" -eq 0 ]; then
        apt-get update -qq || true
        DEBIAN_FRONTEND=noninteractive apt-get install -y "$deb_pkg" || return 1
    else
        printf '\033[1;31m[ERROR]\033[0m Root or sudo privileges required to install %s via apt.\n' "$deb_pkg" >&2
        return 1
    fi
    return 0
}

ui_ensure_dependencies() {
    # 1. Ensure tput (ncurses-bin)
    if ! command -v tput >/dev/null 2>&1; then
        ui_install_package "tput" || true
    fi

    # 2. Ensure dialog (or whiptail fallback)
    if ! command -v dialog >/dev/null 2>&1; then
        printf '\033[1;33m[CyberLab]\033[0m "dialog" is not installed. Attempting auto-installation via apt...\n'
        if ui_install_package "dialog"; then
            printf '\033[1;32m[✓]\033[0m "dialog" successfully installed!\n'
        else
            printf '\033[1;33m[WARN]\033[0m Failed to install dialog. Checking for whiptail fallback...\n'
            if ! command -v whiptail >/dev/null 2>&1; then
                ui_install_package "whiptail" || true
            fi
        fi
    fi

    # 3. Detect and set UI_TOOL
    ui_detect

    # 4. Check docker / docker compose
    if ! command -v docker >/dev/null 2>&1; then
        printf '\033[1;31m[!] WARNING: Docker is not installed or not in PATH!\033[0m\n'
        printf '    CyberLab requires Docker to run containers on Debian / Ubuntu.\n'
        printf '    Install: sudo apt-get update && sudo apt-get install -y docker.io docker-compose-plugin\n\n'
    elif ! docker compose version >/dev/null 2>&1; then
        printf '\033[1;33m[!] WARNING: Docker Compose v2 plugin is missing!\033[0m\n'
        printf '    Install: sudo apt-get install -y docker-compose-plugin\n\n'
    fi
}

# ------------------------------------------------------------------------------
# UI Engine Detection & Initialization
# ------------------------------------------------------------------------------

ui_detect() {
    if command -v dialog >/dev/null 2>&1; then
        UI_TOOL="dialog"
    elif command -v whiptail >/dev/null 2>&1; then
        UI_TOOL="whiptail"
    else
        UI_TOOL="none"
    fi
    export UI_TOOL
}

setup_cyber_theme() {
    DIALOGRC_FILE="${TMPDIR:-/tmp}/.dialogrc_cyberlab_${UID:-$(id -u)}"
    cat <<'RC' >"$DIALOGRC_FILE"
# ==============================================================================
# CyberLab High-Contrast Cyber/Hacker Theme
# ==============================================================================
use_shadow = ON
use_colors = ON

# Screen and shadows
screen_color = (CYAN,BLACK,ON)
shadow_color = (BLACK,BLACK,ON)

# Dialog box and title
dialog_color = (WHITE,BLACK,OFF)
title_color = (CYAN,BLACK,ON)
border_color = (CYAN,BLACK,ON)
border2_color = (BLUE,BLACK,ON)

# Buttons
button_active_color = (BLACK,CYAN,ON)
button_inactive_color = (WHITE,BLACK,OFF)
button_key_active_color = (BLACK,CYAN,ON)
button_key_inactive_color = (CYAN,BLACK,ON)
button_label_active_color = (BLACK,CYAN,ON)
button_label_inactive_color = (WHITE,BLACK,ON)

# Input Box: high-contrast bold white on blue
inputbox_color = (WHITE,BLUE,ON)
inputbox_border_color = (CYAN,BLACK,ON)
inputbox_border2_color = (CYAN,BLACK,ON)

# Search Box
searchbox_color = (WHITE,BLACK,OFF)
searchbox_title_color = (CYAN,BLACK,ON)
searchbox_border_color = (BLUE,BLACK,ON)
searchbox_border2_color = (BLUE,BLACK,ON)

# Indicators & Menus
position_indicator_color = (CYAN,BLACK,ON)
menubox_color = (WHITE,BLACK,OFF)
menubox_border_color = (BLUE,BLACK,ON)
menubox_border2_color = (BLUE,BLACK,ON)

# Items
item_color = (WHITE,BLACK,OFF)
item_selected_color = (BLACK,CYAN,ON)
tag_color = (CYAN,BLACK,ON)
tag_selected_color = (BLACK,CYAN,ON)
tag_key_color = (CYAN,BLACK,ON)
tag_key_selected_color = (WHITE,BLUE,ON)

# Checklists
check_color = (CYAN,BLACK,ON)
check_selected_color = (BLACK,CYAN,ON)

# Arrows & Helpers
uarrow_color = (CYAN,BLACK,ON)
darrow_color = (CYAN,BLACK,ON)
itemhelp_color = (WHITE,BLACK,OFF)

# Gauge
gauge_color = (WHITE,BLUE,ON)

# ==============================================================================
# Full Vim Keybindings
# ==============================================================================

# Checklist navigation: j (\152), k (\153), g (\147), G (\107), h (\150), l (\154)
bindkey checklist \152 ITEM_NEXT
bindkey checklist \153 ITEM_PREV
bindkey checklist \147 PAGE_FIRST
bindkey checklist \107 PAGE_LAST
bindkey checklist \150 FIELD_PREV
bindkey checklist \154 FIELD_NEXT

# Menu navigation
bindkey menu \152 ITEM_NEXT
bindkey menu \153 ITEM_PREV
bindkey menu \147 PAGE_FIRST
bindkey menu \107 PAGE_LAST
bindkey menu \150 FIELD_PREV
bindkey menu \154 FIELD_NEXT

# Menubox navigation
bindkey menubox \152 ITEM_NEXT
bindkey menubox \153 ITEM_PREV
bindkey menubox \147 PAGE_FIRST
bindkey menubox \107 PAGE_LAST
bindkey menubox \150 FIELD_PREV
bindkey menubox \154 FIELD_NEXT

# Msgbox navigation: h/l/j/k for FIELD_PREV/FIELD_NEXT
bindkey msgbox \150 FIELD_PREV
bindkey msgbox \154 FIELD_NEXT
bindkey msgbox \152 FIELD_NEXT
bindkey msgbox \153 FIELD_PREV

# YesNo navigation: h/l/j/k for FIELD_PREV/FIELD_NEXT
bindkey yesno \150 FIELD_PREV
bindkey yesno \154 FIELD_NEXT
bindkey yesno \152 FIELD_NEXT
bindkey yesno \153 FIELD_PREV
RC
    export DIALOGRC="$DIALOGRC_FILE"
}

ui_init() {
    ui_detect
    if [ "$UI_TOOL" = "dialog" ]; then
        setup_cyber_theme
    fi
}

ui_restore_cursor() {
    printf '\033[?25h\033[0 q' >/dev/tty 2>/dev/null || tput cnorm 2>/dev/null || true
}

ui_cleanup() {
    ui_restore_cursor
    if [ -n "$DIALOGRC_FILE" ] && [ -f "$DIALOGRC_FILE" ]; then
        rm -f "$DIALOGRC_FILE" 2>/dev/null || true
    fi
}

# ------------------------------------------------------------------------------
# UI Primitives
# ------------------------------------------------------------------------------

# Responsive terminal dimensions calculator
_ui_calc_dimensions() {
    local -n _lines=$1
    local -n _cols=$2
    _lines=$(tput lines 2>/dev/null || echo 24)
    _cols=$(tput cols 2>/dev/null || echo 80)
    [[ "$_lines" =~ ^[0-9]+$ ]] || _lines=24
    [[ "$_cols" =~ ^[0-9]+$ ]] || _cols=80
}

ui_menu() {
    local title="$1"
    local prompt="$2"
    local default_tag="$3"
    shift 3
    local items=("$@")

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=92
    if [ "$term_cols" -lt 98 ]; then
        box_width=$((term_cols - 6))
    fi
    [ "$box_width" -lt 70 ] && box_width=70
    [ "$box_width" -gt "$term_cols" ] && box_width=$((term_cols - 2))

    local count=$((${#items[@]} / 2))
    local box_height=$((count + 8))
    local max_box=$((term_lines - 4))
    [ "$max_box" -lt 16 ] && max_box=16
    [ "$box_height" -gt "$max_box" ] && box_height="$max_box"
    [ "$box_height" -lt 14 ] && box_height=14

    local menu_height=$count
    local max_menu=$((box_height - 8))
    [ "$menu_height" -gt "$max_menu" ] && menu_height="$max_menu"
    [ "$menu_height" -lt 6 ] && menu_height=6

    case "$UI_TOOL" in
    whiptail)
        whiptail --default-item "$default_tag" --title "$title" --menu "$prompt" \
            "$box_height" "$box_width" "$menu_height" "${items[@]}" 3>&1 1>&2 2>&3 </dev/tty
        ;;
    dialog)
        dialog --default-item "$default_tag" --no-hot-list --stdout --title "$title" --menu "$prompt" \
            "$box_height" "$box_width" "$menu_height" "${items[@]}" </dev/tty
        ;;
    *)
        return 1
        ;;
    esac
}

ui_checklist() {
    local title="$1"
    local prompt="$2"
    shift 2
    local -a items=("$@")

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=92
    if [ "$term_cols" -lt 98 ]; then
        box_width=$((term_cols - 6))
    fi
    [ "$box_width" -lt 70 ] && box_width=70
    [ "$box_width" -gt "$term_cols" ] && box_width=$((term_cols - 2))

    while true; do
        local -a display_items=(
            "ALL" "--> [Select All]" "OFF"
            "NONE" "--> [Deselect All]" "OFF"
        )
        display_items+=("${items[@]}")

        local count=$((${#display_items[@]} / 3))
        local box_height=$((count + 9))
        local max_box=$((term_lines - 4))
        [ "$max_box" -lt 16 ] && max_box=16
        [ "$box_height" -gt "$max_box" ] && box_height="$max_box"
        [ "$box_height" -lt 16 ] && box_height=16

        local list_height=$count
        local max_list=$((box_height - 7))
        [ "$list_height" -gt "$max_list" ] && list_height="$max_list"
        [ "$list_height" -lt 6 ] && list_height=6

        local raw=""
        case "$UI_TOOL" in
        whiptail)
            raw=$(whiptail --title "$title" --checklist "$prompt" \
                "$box_height" "$box_width" "$list_height" "${display_items[@]}" 3>&1 1>&2 2>&3 </dev/tty) || return $?
            ;;
        dialog)
            raw=$(dialog --no-hot-list --stdout --title "$title" --checklist "$prompt" \
                "$box_height" "$box_width" "$list_height" "${display_items[@]}" </dev/tty) || return $?
            ;;
        *)
            return 1
            ;;
        esac

        local -a selected=()
        local line
        local has_all=false
        local has_none=false
        while IFS= read -r line; do
            line="${line//\"/}"
            line="${line// /}"
            [ -z "$line" ] && continue
            if [ "$line" = "ALL" ]; then
                has_all=true
            elif [ "$line" = "NONE" ]; then
                has_none=true
            else
                selected+=("$line")
            fi
        done < <(printf '%s\n' "$raw" | tr ' ' '\n' | tr -d '"')

        if [ "$has_all" = true ]; then
            local i
            for ((i = 0; i < ${#items[@]}; i += 3)); do
                items[i + 2]="ON"
            done
            continue
        fi

        if [ "$has_none" = true ]; then
            local i
            for ((i = 0; i < ${#items[@]}; i += 3)); do
                items[i + 2]="OFF"
            done
            continue
        fi

        if [ ${#selected[@]} -gt 0 ]; then
            printf '%s\n' "${selected[@]}"
        fi
        return 0
    done
}

ui_yesno() {
    local title="$1"
    local prompt="$2"

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=72
    [ "$term_cols" -lt 78 ] && box_width=$((term_cols - 6))
    [ "$box_width" -lt 40 ] && box_width=40

    local box_height=12
    [ "$term_lines" -lt 18 ] && box_height=$((term_lines - 4))
    [ "$box_height" -lt 8 ] && box_height=8

    case "$UI_TOOL" in
    whiptail)
        whiptail --title "$title" --yesno "$prompt" "$box_height" "$box_width" 3>&1 1>&2 2>&3 </dev/tty
        ;;
    dialog)
        dialog --title "$title" --yesno "$prompt" "$box_height" "$box_width" </dev/tty
        ;;
    *)
        return 1
        ;;
    esac
}

ui_input() {
    local title="$1"
    local prompt="$2"
    local default="${3:-}"

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=72
    [ "$term_cols" -lt 78 ] && box_width=$((term_cols - 6))
    [ "$box_width" -lt 40 ] && box_width=40

    local box_height=10
    [ "$term_lines" -lt 16 ] && box_height=$((term_lines - 4))
    [ "$box_height" -lt 8 ] && box_height=8

    case "$UI_TOOL" in
    whiptail)
        whiptail --title "$title" --inputbox "$prompt" "$box_height" "$box_width" "$default" 3>&1 1>&2 2>&3 </dev/tty
        ;;
    dialog)
        dialog --stdout --title "$title" --inputbox "$prompt" "$box_height" "$box_width" "$default" </dev/tty
        ;;
    *)
        return 1
        ;;
    esac
}

ui_msg() {
    local title="$1"
    local text="$2"

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=72
    [ "$term_cols" -lt 78 ] && box_width=$((term_cols - 6))
    [ "$box_width" -lt 40 ] && box_width=40

    local box_height=14
    [ "$term_lines" -lt 20 ] && box_height=$((term_lines - 4))
    [ "$box_height" -lt 8 ] && box_height=8

    case "$UI_TOOL" in
    whiptail)
        whiptail --title "$title" --msgbox "$text" "$box_height" "$box_width" </dev/tty || true
        ;;
    dialog)
        dialog --title "$title" --msgbox "$text" "$box_height" "$box_width" </dev/tty || true
        ;;
    *)
        printf '%s\n\n%s\n' "$title" "$text"
        ;;
    esac
}

ui_textbox() {
    local title="$1"
    local source="${2:-}"
    local tmp_file=""
    local file_to_show=""

    if [ -n "$source" ] && [ -f "$source" ]; then
        file_to_show="$source"
    elif [ -n "$source" ]; then
        tmp_file=$(mktemp "${TMPDIR:-/tmp}/cyberlab_tb_XXXXXX.txt")
        printf '%s\n' "$source" >"$tmp_file"
        file_to_show="$tmp_file"
    elif [ ! -t 0 ]; then
        tmp_file=$(mktemp "${TMPDIR:-/tmp}/cyberlab_tb_XXXXXX.txt")
        cat >"$tmp_file"
        file_to_show="$tmp_file"
    else
        return 1
    fi

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=$((term_cols - 6))
    [ "$box_width" -gt 100 ] && box_width=100
    [ "$box_width" -lt 60 ] && box_width=60

    local box_height=$((term_lines - 4))
    [ "$box_height" -gt 35 ] && box_height=35
    [ "$box_height" -lt 14 ] && box_height=14

    local ret=0
    case "$UI_TOOL" in
    whiptail)
        whiptail --scrolltext --title "$title" --textbox "$file_to_show" \
            "$box_height" "$box_width" </dev/tty || ret=$?
        ;;
    dialog)
        dialog --title "$title" --textbox "$file_to_show" \
            "$box_height" "$box_width" </dev/tty || ret=$?
        ;;
    *)
        cat "$file_to_show"
        ret=0
        ;;
    esac

    if [ -n "$tmp_file" ] && [ -f "$tmp_file" ]; then
        rm -f "$tmp_file" 2>/dev/null || true
    fi
    return $ret
}

ui_tailbox() {
    local title="$1"
    local file="$2"

    if [ ! -f "$file" ]; then
        touch "$file" 2>/dev/null || true
    fi

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=$((term_cols - 6))
    [ "$box_width" -gt 100 ] && box_width=100
    [ "$box_width" -lt 60 ] && box_width=60

    local box_height=$((term_lines - 4))
    [ "$box_height" -gt 35 ] && box_height=35
    [ "$box_height" -lt 14 ] && box_height=14

    case "$UI_TOOL" in
    whiptail)
        whiptail --scrolltext --title "$title" --textbox "$file" \
            "$box_height" "$box_width" </dev/tty
        ;;
    dialog)
        dialog --title "$title" --tailbox "$file" \
            "$box_height" "$box_width" </dev/tty
        ;;
    *)
        tail -f "$file"
        ;;
    esac
}

ui_gauge() {
    local title="$1"
    local prompt="$2"
    local percent="${3:-0}"

    local term_lines term_cols
    _ui_calc_dimensions term_lines term_cols

    local box_width=72
    [ "$term_cols" -lt 78 ] && box_width=$((term_cols - 6))
    [ "$box_width" -lt 40 ] && box_width=40

    local box_height=8
    [ "$term_lines" -lt 16 ] && box_height=$((term_lines - 4))
    [ "$box_height" -lt 6 ] && box_height=6

    case "$UI_TOOL" in
    whiptail)
        whiptail --title "$title" --gauge "$prompt" "$box_height" "$box_width" "$percent"
        ;;
    dialog)
        dialog --title "$title" --gauge "$prompt" "$box_height" "$box_width" "$percent"
        ;;
    *)
        while IFS= read -r line; do
            printf '\r[%s] %s: %s%%' "$title" "$prompt" "$line"
        done
        printf '\n'
        ;;
    esac
}

# ------------------------------------------------------------------------------
# Export Declarations
# ------------------------------------------------------------------------------

export -f ui_detect ui_init ui_restore_cursor ui_cleanup
export -f ui_get_sudo ui_install_package ui_ensure_dependencies
export -f ui_menu ui_checklist ui_yesno ui_input ui_msg ui_textbox ui_tailbox ui_gauge

# Auto-detect on source
ui_detect
