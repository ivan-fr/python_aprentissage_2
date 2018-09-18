def name(function):
    def inner(*args, **kwargs):
        print('running this method: ' + function.__name__)
        return function(*args, **kwargs)

    return inner


class CoffeMachine:
    WATER_LEVEL = 100

    @name
    def _start_machine(self):
        if 20 <= self.WATER_LEVEL <= 100:
            return True
        else:
            print('pls, add water.')
            return False

    @name
    def __boil_water(self):
        return 'boiling...'

    @name
    def make_coffe(self):
        if self._start_machine():
            self.WATER_LEVEL -= 20
            print(self.__boil_water())
            print('coffee is ready my dear.')


machine = CoffeMachine()
# for i in range(5):
#    machine.make_coffe()
machine.make_coffe()
machine._start_machine()
machine._CoffeMachine__boil_water()
