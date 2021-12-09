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
    {item => ['st',               'Terminal',     'st']},
    {item => ['xdg-open .',       'File Manager', 'system-file-manager']},
    {item => ['xdg-open http://', 'Web Browser',  'firefox']},
    {item => ['notepadqq',        'Notepad',      'notepadqq']},
    {item => ['xterm',            'Xterm',        'utilities-terminal']},

    {sep => 'Menus'},

    {beg => ['Categories', 'view-categories']},
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

    {item => ['menu_apps',     'Applications', 'app-launcher']},
    {item => ['menu_settings', 'Settings',     'applications-system']},
    {item => ['menu_exit',     'Exit',         'system-shutdown']},

    {sep => 'Openbox'},

    {beg => ['Generator', 'applications-engineering']},
      {item => ['obmenu-generator -d', 'Refresh cache', 'view-refresh']},
      {item => ['obmenu-generator -s -i -c', 'Generate Static Menu',  'accessories-text-editor']},
      {item => ['obmenu-generator -p -i',    'Generate Dynamic Menu', 'accessories-text-editor']},
      {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Edit Schema', 'text-x-generic']},
      {item => ["$editor ~/.config/obmenu-generator/config.pl", 'Edit Config', 'text-x-generic']},
    {end => undef},

    {item => ['openbox --reconfigure', 'Reconfigure', 'view-refresh-symbolic']},
    {item => ['openbox --restart',     'Restart',     'system-restart-symbolic']},
    {exit => ['Logout',  'application-exit-symbolic']},

]
