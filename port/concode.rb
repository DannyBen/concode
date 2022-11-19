require 'digest'

def adjectives_list
  @adjectives ||= adjectives!
end

def adjectives!
  result = ["aback", "abaft", "abandoned", "abashed", "aberrant"]
  result.sort_by!(&:size)
end

def nouns_list
  @nouns ||= nouns!
end

def nouns!
  result = ["a", "ability", "abroad", "abuse", "access", "accident", "account"]
  result.sort_by!(&:size)
end

def adjective_lengths
  @adjective_lengths ||= collect_lengths(adjectives_list)
end

def noun_lengths
  @noun_lengths ||= collect_lengths(nouns_list)
end

def collect_lengths(source)
  result = {}
  (3..9).each do |len|
    result[len] = source.select { |i| i.size <= len }.size
  end
  result
end

def codenamize_particles(obj = nil, adjectives: 1, max_chars: 0, algo: 'md5')
  max_chars = 3 if max_chars.between? 1, 3
  max_chars = 0 if max_chars > 9

  # Prepare codename word lists and calculate size of codename space
  particles = [nouns_list]
  adjectives.times { particles.push adjectives_list }

  if max_chars > 0
    particles[0] = nouns_list[0...noun_lengths[max_chars]]
    adjectives.times { |i| particles[i + 1] = adjectives_list[0...adjective_lengths[max_chars]] }
  end

  total_words = particles.map(&:size).reduce(:*)

  # Return size of codename space if no object is passed
  return total_words unless obj

  # Convert numbers to strings
  obj = obj.to_s
  obj_hash = Digest::MD5.hexdigest(obj).to_i(16) * 36413321723440003717

  # Calculate codename words
  index = obj_hash % total_words

  codename_particles = []
  particles.each do |p|
    codename_particles.push p[index % p.size]
    index = (index / p.size).to_i
  end

  codename_particles.reverse
end

def codenamize_space(adjectives: 1, max_chars: 0, algo: 'md5')
  codenamize_particles adjectives: adjectives, max_chars: max_chars, algo: algo
end

def codenamize(obj, adjectives: 1, max_chars: 0, join: "-", capitalize: false, algo: 'md5')
  codename_particles = codenamize_particles obj, adjectives: adjectives, max_chars: max_chars, algo: algo
  join = '' unless join
  codename_particles.map!(&:capitalize) if capitalize
  codename_particles.join join
end

p codenamize 'asd', max_chars: 6, adjectives: 2, capitalize: true
