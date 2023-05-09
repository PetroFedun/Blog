class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Article
    
    return unless user.present?

    can :create, Article
    can :read, Article, author_id: user.id
    can :edit, Article, author_id: user.id
    can :destroy, Article, author_id: user.id
    can :arhive, Article, author_id: user.id
    can :restore, Article, author_id: user.id

    can :update, Comment, author_id: user.id
    can :delete, Comment, article: { author_id: user.id }
    can :delete, Comment, author_id: user.id
  end
end
