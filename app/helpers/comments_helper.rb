module CommentsHelper
    def profile_avatar(user)
        if user.avatar != '' && !user.avatar.nil?
            user.avatar
        else
            'avatar/unlogo.jpg'
        end
    end
end
