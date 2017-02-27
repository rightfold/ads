from glob import glob
from os.path import basename, splitext
import subprocess
from waflib.TaskGen import task_gen

def _test_name(path):
    return splitext(basename(path))[0]

def options(ctx):
    ctx.load('compiler_fc')

def configure(ctx):
    ctx.load('compiler_fc')
    ctx.env.append_value('FCFLAGS', '-Wall')
    ctx.env.append_value('FCFLAGS', '-fcheck=all')
    ctx.env.append_value('LINKFLAGS', '-lzmq')

def build(ctx):
    task_gen.mappings['.f03'] = task_gen.mappings['.f']

    ctx.objects(source=glob('lib/ads_*.f90') + glob('lib/ads_*.f03'), target='lib')

    ctx.program(source='src/adsd.f90', target='adsd', use='lib')

    for test in glob('test/*_test.f90'):
        ctx.program(source=test, target=_test_name(test), use='lib')

def test(ctx):
    for test in glob('test/*_test.f90'):
        subprocess.check_call(['build/' + _test_name(test)])
