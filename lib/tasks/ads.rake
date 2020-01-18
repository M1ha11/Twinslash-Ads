namespace :ads do
  desc "TODO"
  task publish: :environment do
    Advertisement.all.where(state: 'approved').update(state: 'published')
  end

  desc "TODO"
  task archive: :environment do
    Advertisement.all.where(state: 'published').update(state: 'archived')
  end

end
