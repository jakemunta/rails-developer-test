class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
        user ||= User.new

        if user.admin?
         #can :manage, :all
           can :manage, User 
           cannot :write, Artical
           cannot :update, Artical
           cannot :destroy, Artical
       else
         can :read, Artical if user.has_role?(:vanilla, Artical)
         can :write, Artical if user.has_role?(:editor, Artical)
         can :wirte, Artical , :id => Artical.with_role(:editor, user).pluck(:id) 
         can :update, Artical if user.has_role?(:editor, Artical)
         can :update, Artical , :id => Artical.with_role(:editor, user).pluck(:id) 
         can :destroy, Artical if user.has_role?(:editor, Artical)
         can :destroy, Artical , :id => Artical.with_role(:editor, user).pluck(:id) 
       
         canot :manage, User if user.has_role?(:vanilla) || user.has_role?(:editor)
       end
  end
end
