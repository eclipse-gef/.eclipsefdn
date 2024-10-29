local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-gef') {
  settings+: {
    description: "",
    members_can_change_project_visibility: false,
    members_can_change_repo_visibility: false,
    members_can_create_teams: false,
    members_can_delete_repositories: false,
    name: "GEF Project",
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('gef') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse GEF™",
      homepage: "https://www.eclipse.org/gef/",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/gef/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
    },
    orgs.newRepo('gef-classic') {
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Eclipse GEF(tm) Classic code",
      has_discussions: true,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      topics+: [
        "eclipse",
        "gef",
        "java"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/gef/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: 0,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
  ],
}
