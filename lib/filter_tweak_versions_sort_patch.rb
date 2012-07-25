module FilterTweakVersionsSortPatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :available_filters, :hide_closed_versions
    end
  end

  module InstanceMethods
    def available_filters_with_hide_closed_versions
      available_filters_without_hide_closed_versions

      opened_versions, closed_versions = \
        if project
          project.shared_versions.all.partition{|v| v.open?}
        else
          Version.visible.find_all_by_sharing('system').partition{|v| v.open?}
        end
      date_unlimited_versions, date_limited_versions = opened_versions.partition{|v| v.effective_date.nil?}
      options = [["----- opened versions -----", '']]
      options += date_limited_versions.sort_by{|v| v.effective_date}.collect{|s| ["#{s.project.name} - #{s.name}", s.id.to_s] }
      options += date_unlimited_versions.sort.reverse.collect{|s| ["#{s.project.name} - #{s.name}", s.id.to_s] }
      options.push ['', '']
      options.push ["----- closed versions -----", '']
      options += closed_versions.sort.reverse.collect{|s| ["#{s.project.name} - #{s.name}", s.id.to_s] }
      @available_filters["fixed_version_id"][:values] = options 

      @available_filters
    end
  end
end
