#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(...)},
    beg:       begin of a category                        {beg => ["name", "icon"]},
    end:       end of a category                          {end => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [

    #          COMMAND                 LABEL              ICON
    {item => ['st',               'Terminal',     'utilities-terminal']},
    {item => ['xdg-open .',       'File Manager', 'system-file-manager']},
    {item => ['xdg-open http://', 'Web Browser',  'firefox']},
    {item => ['notepadqq',        'Notepad',      'notepadqq']},

    {beg => ['Applications', 'app-launcher']},
      #        NAME            LABEL                ICON
      {cat => ['utility',     'Accessories', 'applications-utilities']},
      {cat => ['development', 'Development', 'applications-development']},
      {cat => ['education',   'Education',   'applications-science']},
      {cat => ['game',        'Games',       'applications-games']},
      {cat => ['graphics',    'Graphics',    'applications-graphics']},
      {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
      {cat => ['network',     'Network',     'applications-internet']},
      {cat => ['office',      'Office',      'applications-office']},
      {cat => ['other',       'Other',       'applications-other']},
      {cat => ['settings',    'Settings',    'applications-accessories']},
      {cat => ['system',      'System',      'applications-system']},
    {end => undef},

    {sep => '  System'},

    {beg => ['Settings', 'applications-system']},

      {item => ["obconf",    "Openbox Settings",      "obconf"]},
      {item => ["tint2conf", "Tint2 Settings",        "tint2conf"]},
      {item => ["arandr",    "Display Settings",      "system-config-display"]},
      {item => ["ezame",     "Applications Settings", "ezame"]},
      {item => ["gufw",      "Firewall Settings",     "gufw"]},

      {sep => '  Scripts'},

      {item => ["st -t Backup -e tmux new-session -d '~/.scripts/particular/backup.sh; read' \; attach", "Backup", "grsync"]},
      {item => ["st -t Upgrade -e tmux new-session -d 'paru -Syyu; read' \; attach", "Upgrade", "start-here-archlinux"]},
      {item => ["toggle_compositor", "Toggle Compositor","compton"]},
      {item => ["service_wrap mpd toggle mpd 'Music Player Daemon' --user", "Toggle MPD","mpd"]},
      {item => ["service_wrap tor toggle tor", "Toggle Tor","tor"]},
    {end => undef},


    {beg => ['Openbox', 'window-duplicate']},
      {item => ['openbox --reconfigure', 'Reconfigure', 'view-refresh-symbolic']},
      {item => ['openbox --restart',     'Restart',     'system-restart-symbolic']},
      {exit => ['Logout',  'system-log-out']},

      {sep => '  Generator'},

      {item => ['obmenu-generator -d', 'Refresh cache', 'view-refresh']},
      {item => ['obmenu-generator -s -i -c', 'Generate Static Menu',  'accessories-text-editor']},
      {item => ['obmenu-generator -p -i',    'Generate Dynamic Menu', 'accessories-text-editor']},
      {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Edit Schema', 'text-x-generic']},
      {item => ["$editor ~/.config/obmenu-generator/config.pl", 'Edit Config', 'text-x-generic']},
    {end => undef},

    {item => ["systemctl poweroff",     "Shutdown",  "system-shutdown"]},
    {item => ["systemctl reboot",       "Reboot",    "system-reboot"]},
    #{item => ["systemctl hybrid-sleep", "Hibernate", "system-hibernate" ]},

]
