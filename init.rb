require 'redmine'

Redmine::Plugin.register :redmine_filter_tweak_versions_sort do
  name 'Redmine Filter Tweak Versions Sort plugin'
  author 'Shingo Sekiguchi'
  description 'Sort the versions in issues filter option.'
  version '0.0.1'
  url 'https://github.com/SIN-777/redmine_filter_tweak_versions_sort'
  author_url ''
end

require File.dirname(__FILE__) + '/lib/filter_tweak_versions_sort_patch.rb'
Query.send(:include, FilterTweakVersionsSortPatch)
