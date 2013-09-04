class ProgrammesController < ApplicationController

  def related
    pid = params[:pid]
    if Programmes.episode?(pid)
      dbpedia_keys = Programmes.get_tagged_resources_for_pid(pid)
      @entities = dbpedia_keys.map { |dbpedia_key| Entity.fetch_by_dbpedia_key(dbpedia_key) }.compact
    end

    @entities_contrib, @contribs = Nitro.find_contributors(pid)

    render 'profiles/list_contribs', :layout => false
  end
end
