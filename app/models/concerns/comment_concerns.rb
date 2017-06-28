
module CommentConcerns
   
  private

    def did_create
      new_event('commented')
    end

    def new_event(action, info = nil)
      return if commentable.nil?
      origin = nil
      
      if commentable.methods.include? :project
        origin = commentable.project
      else
        # or something else
      end
      
      if origin.nil?  
        logger.error "unknown comment origin. #{commentable}"
        return
      end
      
      super(action, origin, self, info)
    end

end


