module LevensteinWithPath

  # Computes the levenstein distance between two sequences.
  #
  # Unlike other Ruby libraries, this one:
  #
  #   - Can tell you not just the optimal score, but the sequence of operations to get it.
  #     This is useful if you want to present a nice diff.
  #   - Lets you pass either strings or array of some other atomic tokens
  #     (like words, lines, nucleobases, etc.).
  #
  # It is based on the [Wagner-Fischer algorithm](https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm),
  # which is `O(n^2)` but lets you retain the history of edits.
  # See also [that algorithm applied to Levenstein distance](https://en.wikipedia.org/wiki/Levenshtein_distance#Computing_Levenshtein_distance).
  class Path
    attr_reader :tokens1, :tokens2
    attr_reader :scores, :score

    def initialize(tokens1, tokens2)
      @tokens1 = if tokens1.is_a?(String)
                   tokens1.chars
                 else
                   tokens1
                 end
      @tokens2 = if tokens2.is_a?(String)
                   tokens2.chars
                 else
                   tokens2
                 end

      s = @tokens1
      t = @tokens2
      m = s.size
      n = t.size
      d = 0.upto(m).map { [0] * (n + 1)}
      1.upto(m) {|i| d[i][0] = i}
      1.upto(n) {|j| d[0][j] = j}

      # rubocop:disable Layout/SpaceInsideReferenceBrackets
      1.upto(n) do |j|
        1.upto(m) do |i|
          cost = s[i - 1] == t[j - 1] ? 0 : 1
          d[i][j] = [
            d[i - 1][j    ] + 1,    # delete
            d[i    ][j - 1] + 1,    # insert
            d[i - 1][j - 1] + cost  # keep/swap
          ].min
        end
      end
      # rubocop:enable Layout/SpaceInsideReferenceBrackets

      @scores = d
      @score = d[m][n]
    end

    def edits
      return @edits if @edits
      @edits = []
      s = @tokens1
      t = @tokens2
      m = s.size
      n = t.size
      i = m
      j = n
      d = @scores
      while i > 0 or j > 0
        cur_score = d[i][j]
        insert_score = j > 0 ? d[i][j - 1] : cur_score + 1
        delete_score = i > 0 ? d[i - 1][j] : cur_score + 1
        keep_or_swap_score = (i > 0 and j > 0) ? d[i - 1][j - 1] : cur_score + 1
        best_score = [insert_score, delete_score, keep_or_swap_score].min
        if best_score == keep_or_swap_score
          if cur_score == keep_or_swap_score
            @edits << Keep.new(s[i - 1])
          else
            @edits << Swap.new(s[i - 1], t[j - 1])
          end
          i -= 1
          j -= 1
        elsif best_score == insert_score
          @edits << Insert.new(t[j - 1])
          j -= 1
        else
          @edits << Delete.new(s[i - 1])
          i -= 1
        end
      end
      @edits.reverse!
    end

  end

  # rubocop:disable Layout/EmptyLineBetweenDefs
  class Edit
  end

  class Keep < Edit #:nodoc:
    attr_reader :token
    def initialize(token)
      @token = token
    end
    def ==(other)
      other.is_a?(Keep) and other.token == token
    end
  end

  class Delete < Edit #:nodoc:
    attr_reader :token
    def initialize(token)
      @token = token
    end
    def ==(other)
      other.is_a?(Delete) and other.token == token
    end
  end

  class Insert < Edit #:nodoc:
    attr_reader :token
    def initialize(token)
      @token = token
    end
    def ==(other)
      other.is_a?(Edit) and other.token == token
    end
  end

  class Swap < Edit #:nodoc:
    attr_reader :token1, :token2
    def initialize(token1, token2)
      @token1 = token1
      @token2 = token2
    end
    def ==(other)
      other.is_a?(Swap) and other.token1 == token1 and other.token2 == token2
    end
  end
  # rubocop:enable Layout/EmptyLineBetweenDefs

end
