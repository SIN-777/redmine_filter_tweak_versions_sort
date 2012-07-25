require 'redmine'

Redmine::Plugin.register :redmine_filter_tweak_versions_sort do
  name 'Redmine Filter Tweak Versions Sort plugin'
  author 'Shingo Sekiguchi'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url ''
  author_url ''
end

require File.dirname(__FILE__) + '/lib/filter_tweak_versions_sort_patch.rb'
Query.send(:include, FilterTweakVersionsSortPatch)
