User.destroy_all
Workshop.destroy_all
Project.destroy_all
Work.destroy_all

#Hash with fake users
f_u = Array.new
f_u[0] = {:firstname => 'Patrick', :lastname => 'Chirac', :email => 'p.c@gmail.com', :year =>2016, :password => 'pastis'}
f_u[1] = {:firstname => 'Régis-robert', :lastname => 'Régis-robert', :email => 'dagobert@gmail.com', :year =>2016, :password => 'hugodelire'}
f_u[2] = {:firstname => 'Nicolas', :lastname => 'Sarkozy', :email => 'talonnette@gmail.com', :year =>2016, :password => '#notrialforme'}
f_u[3] = {:firstname => 'Obiwan', :lastname => 'Kenoby', :email => 'foreveralone@gmail.com', :year =>2016, :password => 'notthepasswordyouarelookingfor'}
f_u[4] = {:firstname => 'Bob', :lastname => 'l\'éponge', :email => 'jesuispasunemmental@gmail.com', :year =>2016, :password => 'garyforever'}
f_u[5] = {:firstname => 'Speedy', :lastname => 'Gonzalez', :email => 'SoyMexicanos@gmail.com', :year =>2016, :password => 'ouiunpeuraciste'}
f_u[6] = {:firstname => 'Fanklin', :lastname => 'la tortue', :email => 'saitlasserseslacets@gmail.com', :year =>2016, :password => 'napasdechaussures'}
f_u[7] = {:firstname => 'Mr', :lastname => 'Robot', :email => 'h-a-t@gmail.com', :year =>2016, :password => 'hacker/justicier'}
f_u[8] = {:firstname => 'Robin', :lastname => 'Wood', :email => 'MorningWood@gmail.com', :year =>2016, :password => 'envraijesuisjustesdf'}
#the loop which create each user
f_u.each do |user|
  new_user = User.new(:firstname => user[:firstname], :lastname => user[:lastname], :email => user[:email], :year => user[:year], :password => user[:password], :password_confirmation => user[:password] )
  new_user.save!
end
#Fake worshop Hash
f_w = Array.new
f_w[0] = {:name => 'SQL', :description => 'Création d\'un schéma de base de données, associé à un CRUD et des exemples de requêtes SQL ', :teacher => 'Hitcham', :begins => '16-09-2016', :ends => '20-01-2017', :teamnumber =>'3', :teamgeneration => 0, :created_at => '16-09-2016'}
f_w[1] = {:name => 'Devis', :description => 'Éditer un devis pour un projet fictif avec M Ricard qui s\'amuse à jouer M.Fortineau', :teacher => 'Laurent', :begins => '20-09-2016', :ends => '16-10-2016', :teamnumber =>'2', :teamgeneration => 0, :created_at => '20-09-2016', :updated_at =>'20-09-2016'}
f_w[2] = {:name => 'Ruby-on-Rails', :description => 'Premier projet de développement en groupe, avec la technologie Ruby-on-Rails', :teacher => 'Kora', :begins => '25-09-2016', :ends => '25-10-2016', :teamnumber =>'2', :teamgeneration => 0, :created_at => '25-09-2016', :updated_at =>'25-09-2016'}
f_w.each do |workshop|
  users_count = User.count
  creator = User.limit(1).offset(rand(users_count)).first
  workshop = Workshop.create!({:name => workshop[:name], :description => workshop[:description], :user_id => creator.id, :teacher => workshop[:teacher], :begins => workshop[:begins], :ends => workshop[:ends], :teamnumber => workshop[:teamnumber], :teamgeneration => workshop[:teamgeneration], :created_at => workshop[:created_at], :updated_at =>workshop[:updated_at] })
  workshop[:teamnumber].times do |i|
    Project.create!({ name: workshop.name + '_#'+ i.to_s, description: workshop.description + '_#'+ i.to_s, created_at: workshop[:created_at], updated_at: workshop[:updated_at], workshop_id: workshop[:id] })
  end
end

projects = Project.all
i = 0
projects.each do |project|
  offset = i * 3
  users_in_project = User.limit(3).offset(offset)
  j = 1
  users_in_project.each do |user|
    project_leader = false
    if ( 3 % (j ) ) == 0
      project_leader = true
    end
    Work.create!({user_id: user.id, project_id: project.id, project_leader: project_leader, created_at: project.created_at, updated_at: project.created_at })
    j = j +1
  end
  i = i + 1
end
