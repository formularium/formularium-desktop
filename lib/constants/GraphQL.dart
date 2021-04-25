

class GQLQueries {
  static const String ME = """
  query me {
      me {
        firstName
        lastName
        email
        id
    }
  }""";

  static const String SUBMIT_KEY ="""
  mutation(\$publicKey: String!) {
      submitEncryptionKey(publicKey: \$publicKey ) {
        success
        encryptionKey {
          id
          active
          publicKey
        }
      }
    }
  """;

  static const String ALL_FORM_SUBMISSIONS ="""
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
}


