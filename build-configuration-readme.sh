# These are commands that need to be run in shell.cloud.google.com to deploy the app to Google Cloud Run
# They are not meant to be run in a local terminal, and will set up the build configuration for the app to be deployed to Google Cloud Run
# They set environment variables for Supabase. They work with the cloudbuild.yaml file in the root of the project, and the Dockerfile in the root of the project

# NOTE: THIS IS DONE IN TERMINAL. IT COULD ALSO BE SET UP USING THE GUI (see bottom)

gcloud builds submit --tag gcr.io/Ynextjs-boilerplate-foreal/YOUR_IMAGE_NAME:TAG \
  --substitutions _NEXT_PUBLIC_SUPABASE_URL="https://your-project.supabase.co",_NEXT_PUBLIC_SUPABASE_ANON_KEY="your-anon-key" \
  .


  gcloud run deploy next_supabase_boilerplate_raw \
  --image us-east1-docker.pkg.dev/nextjs-boilerplate-foreal/cloud-run-source-deploy/next_supabase_boilerplate_raw:next-supabase-boilerplate-raw \
  --platform managed \
  --region us-east1 \
  --allow-unauthenticated


  gcloud builds submit --tag us-east1-docker.pkg.dev/nextjs-boilerplate-foreal/cloud-run-source-deploy/next_supabase_boilerplate_raw:latest \
  --substitutions _NEXT_PUBLIC_SUPABASE_URL="https://ypbktkcwohvbnszjpzkz.supabase.co",_NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwYmt0a2N3b2h2Ym5zempwemt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjAzMTY1MjMsImV4cCI6MjAzNTg5MjUyM30.RYhmqpcnd5mMbKTl6L77HPBbLNTj2oBQ38nX3DWbXHI" \
  .


  gcloud builds submit --config cloudbuild.yaml \
  --substitutions _NEXT_PUBLIC_SUPABASE_URL="https://ypbktkcwohvbnszjpzkz.supabase.co",_NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwYmt0a2N3b2h2Ym5zempwemt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjAzMTY1MjMsImV4cCI6MjAzNTg5MjUyM30.RYhmqpcnd5mMbKTl6L77HPBbLNTj2oBQ38nX3DWbXHI"\
  
  # Claude chat about using GUI

  #could i have done this all from the UI instead of the console terminal?

#   Yes, you can certainly perform these operations from the Google Cloud Console UI instead of using the terminal. Here's how you can do it:

# 1. Build and Push the Image:

#    a. Go to Cloud Build in the Google Cloud Console.
#    b. Click "Create Build"
#    c. Choose "Cloud Build configuration file (yaml or json)" 
#    d. Upload your source code (you can connect to a repository or upload a ZIP)
#    e. Select your cloudbuild.yaml file
#    f. Under "Substitution variables", add:
#       - _NEXT_PUBLIC_SUPABASE_URL
#       - _NEXT_PUBLIC_SUPABASE_ANON_KEY
#    g. Fill in the values for these variables
#    h. Click "Create" to start the build

# 2. Deploy to Cloud Run:

#    a. Go to Cloud Run in the Google Cloud Console
#    b. Click "Create Service"
#    c. Choose "Deploy one revision from an existing container image"
#    d. Select the image you just built (it should be in your Artifact Registry)
#    e. Configure the service:
#       - Set the service name
#       - Choose the region
#       - Set "Authentication" to "Allow unauthenticated invocations" if needed
#    f. Under "Container, Networking, Security", you can set environment variables if needed
#    g. Click "Create" to deploy the service

# This UI-based approach offers several advantages:

# 1. It's more visual and may be easier for those less comfortable with command-line interfaces.
# 2. It provides a clear step-by-step process.
# 3. It often includes helpful tooltips and documentation links.
# 4. It can be easier to manage environment variables and settings without remembering specific command flags.

# However, the command-line approach can be faster for experienced users and is more easily scriptable for automation. Both methods are valid, and you can choose whichever you're more comfortable with or whichever fits your workflow better.

# Remember, whether you use the UI or the command line, the underlying processes are the same. The UI is essentially constructing and running the same commands you would type in the console, just with a graphical interface.