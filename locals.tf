locals{
  tags = {
      company             = var.company
      region              = var.prefix_region
      lob                 = var.lob
      env                 = var.env
      created_by          = "terraform"
      project             = var.project
      Modifed_date        = formatdate("YYYY-MM-DD", timestamp())
      repo_url            = var.repo_url
  }
}