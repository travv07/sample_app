# frozen_string_literal: true

namespace :unicorn_action do
  desc 'Restart the unoicorn process'
  task :restart do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          invoke 'unicorn:stop'
          sleep 2
          invoke 'unicorn:start'
        end
      end
    end
  end
end
