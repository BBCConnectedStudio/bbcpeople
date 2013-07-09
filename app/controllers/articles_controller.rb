class ArticlesController < ApplicationController

  def related
    @people = ::Juicer.people_related_to_article(params[:id])
    @organisations = ::Juicer.organisations_related_to_article(params[:id])

    @entities = @people.concat(@organisations)

    render :list, :layout => false
  end
end
