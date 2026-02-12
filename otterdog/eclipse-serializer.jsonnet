local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('technology.serializer', 'eclipse-serializer') {
  settings+: {
    description: "",
    name: "Eclipse Serializer",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('ORG_GPG_PASSPHRASE') {
      value: "pass:bots/technology.serializer/gpg/passphrase",
    },
    orgs.newOrgSecret('ORG_GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.serializer/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_PASSWORD') {
      value: "pass:bots/technology.serializer/central.sonatype.org/token-password",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_USERNAME') {
      value: "pass:bots/technology.serializer/central.sonatype.org/token-username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('serializer') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: true,
      description: "Serializer project",
      has_discussions: true,
      homepage: "",
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          requires_pull_request: true,
          requires_commit_signatures: true,
          required_approving_review_count: 1
        },
      ],
      topics+: [
        "java",
        "object-graph",
        "security",
        "serializer"
      ],
      web_commit_signoff_required: false,
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
