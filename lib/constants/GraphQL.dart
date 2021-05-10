class GQLQueries {
  static const String ME = """
  query me {
      me {
        firstName
        lastName
        email
        id
        encryptionKeys {
          edges {
            node {
              keyName
              publicKey
              active
              id
              fingerprint
            }
          }
        }
    }
  }""";

  static const String SUBMIT_KEY = """
  mutation(\$publicKey: String!, \$keyName: String!) {
      submitEncryptionKey(publicKey: \$publicKey, keyName: \$keyName ) {
        success
        encryptionKey {
          id
          active
          publicKey
        }
      }
    }
  """;

  static const String APPROVE_USER_KEY = """
  mutation(\$publicKeyId: ID!) {
        activateEncryptionKey(publicKeyId: \$publicKeyId, keys: []) {
    encryptionKey {
      id
      fingerprint
    }
  }
    }
  """;

  static const String CREATE_TEAM = """
  mutation(\$keys: [EncryptionKeysInputType], \$name: String!) {
  createTeam(keys: \$keys, name: \$name) {
    team {
      name
      domain
      id
    }
  }
}
  """;
  static const String ADD_CSR_TO_TEAM = """
  mutation(\$teamId: ID!, \$csr: String!, \$publicKey: String!) {
  addCsrForTeam(teamId: \$teamId, csr: \$csr, publicKey: \$publicKey) {
    team {
      name
      domain
      id
      publicKey
      certificates {
        edges {
          node {
            csr
            publicKey
            createdAt
            status
      			certificate
          }
        }
      }
    }
  }
}
  """;

  static const String REMOVE_KEY = """
 mutation(\$publicKeyId: ID!) {
        removeEncryptionKey(publicKeyId: \$publicKeyId) {
    success
  }
}
  """;

  static const String ALL_TEAMS = """
 query allTeams {
  allTeams {
    edges {
      node {
        name
        status
        id
        publicKey
        csr
        createdAt
        certificate
        publicKey
        members {
          edges {
            node {
              id 
              key
              role
              memberSince
              user {
                firstName
                lastName
              }
            }
          }
        }
      }
    }
  }
}
  """;

  static const String ALL_FORM_SUBMISSIONS = """
  query allFormSubmissions {
      allFormSubmissions {
        edges {
          node {
            id
            signature
            submittedAt
            data
            form {
              name
              description
              jsCode
            }
          }
        }
      }
    }
  }
  """;

  static const String ALL_INACTIVE_ENCRYPTION_KEYS = """
  query allInactiveEncryptionKeys {
      
  allInactiveEncryptionKeys {
    edges {
      node {
      id 
      fingerprint
      user {
        firstName
        lastName
        profilePicture
      }
    }
    }
  }
  }
  """;
}
