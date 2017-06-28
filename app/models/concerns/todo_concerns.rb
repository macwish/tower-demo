
module TodoConcerns
   
  private

    def did_create
      new_event('created')
    end
    
    def did_destroy
      new_event('removed', {description: content})
    end

    def did_update
      if saved_change_to_attribute?(:completed)
        if self.completed
          new_event('finished')
        else
          new_event('reworked')
        end
      end

      if saved_change_to_attribute?(:assignd_to_member_id)
        if self.assignd_to_member_id_before_last_save.nil?
          new_event('assigned')
        else
          new_event('reassigned')
        end
      end

      if saved_change_to_attribute?(:deadline)
        new_event('changed_deadline')
      end

      if saved_change_to_attribute?(:content)
        new_event('updated_content')
      end
    end

    # 

    def new_event(action, info = nil)
      super(action, self.project, self, info)
    end

end


