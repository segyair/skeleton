require 'fileutils'
require 'find'
require 'erb'

def log(msg)
  puts "DEBUG: #{msg}"
end

cfg = {}
cfg[:package_name]  = 'greeter'
cfg[:version]       = '0.0.1'
cfg[:release]       = '1'
cfg[:summary]       = 'sample greeter app to demonstrate all'
cfg[:buildroot]     = '/home/anikan/greeter/current'
cfg[:description]   = 'nginx, puma, grape, rpm, activerecord'
cfg[:user]          = 'anikan'
cfg[:group]         = 'anikan'
cfg[:dirs]          = []
cfg[:files]         = []

HOMEDIR            = "/home/#{cfg[:user]}/dev/tutorial/#{cfg[:package_name]}"
BASEDIR            = "#{HOMEDIR}/code/"
SPEC_TEMPLATE_FILE = "#{HOMEDIR}/rpm_builder/rpm_spec.erb"
SPEC_PATH          = "#{HOMEDIR}/rpm_builder/#{cfg[:package_name]}.spec"

# -- don't change manually below here --

Dir.chdir(BASEDIR) do
  Find.find('.') do |full_path|
    next if full_path == '.'
    next if full_path == './home'
    next if full_path == './home/anikan'
    File.file?(full_path) ? (cfg[:files] << full_path[1..-1]) : (cfg[:dirs] << full_path[1..-1])
  end
end
log "using template: #{SPEC_TEMPLATE_FILE}"
spec_template = File.read(SPEC_TEMPLATE_FILE)
spec_content = ERB.new(spec_template).result(binding)
spec_dest = File.join(File.dirname(SPEC_TEMPLATE_FILE),cfg[:package_name] + '.spec')
log "writing spec file at: #{spec_dest}"
File.write(spec_dest, spec_content)

PACKAGE  = "#{cfg[:package_name]}-#{cfg[:version]}-#{cfg[:release]}.x86_64"
# rpmbuild directories
RPMDST   = "/home/#{cfg[:user]}/rpmbuild/RPMS/x86_64/#{PACKAGE}.rpm"
BUILDDIR = "/home/#{cfg[:user]}/rpmbuild/BUILDROOT/#{PACKAGE}"

log "recreate build dir: #{BUILDDIR}"
FileUtils.rm_rf(BUILDDIR)
FileUtils.mkdir_p(BUILDDIR)

log "copy package content to build dir"
FileUtils.cp_r("#{BASEDIR}/.", BUILDDIR)

log "build rpm from spec file: #{SPEC_PATH}"
cmd = "rpmbuild -ba #{SPEC_PATH}"
system(cmd)
unless $?.success?
  log "RPM build error. RC: #{$?}, Command: #{cmd}" 
  exit 1
end

unless File.file?(RPMDST)
  log "RPM not found at #{RPMDST}. exit."
  exit 1
end

final_dest = File.dirname(SPEC_TEMPLATE_FILE) + "/rpms/"
log "moving the rpm to: #{final_dest}"
FileUtils.mv(RPMDST, final_dest)
unless File.file?(File.join(final_dest, PACKAGE + '.rpm'))
  log "RPM build error. RPM not found at: #{final_dest}"
  exit 1
end

log "RPM created successfuly!"
